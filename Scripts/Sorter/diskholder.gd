extends Node3D
class_name Diskholder

var closed: bool = true

@onready var disk_mesh: MeshInstance3D = $DiskholderMesh
@onready var disk_body: AnimatableBody3D = $DiskholderBody
@onready var selectable_component: Selectable = $DiskholderMesh/Selectable
@onready var insert_marker: Node3D = %InsertMarker

var disk_item: DiskItem = null

signal diskholder_opened(name: String)
signal diskholder_closed(name: String) # i havent no use for this signal yet
signal disk_played(disk: DiskItem)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selectable_component.mesh_instance = disk_mesh
	selectable_component.select = handle_select

	# close the diskholder when the game starts
	_on_open_close_closed()


## Handles inserting and retrieving disks operator.
## See [method insert_disk] and [method retrieve_disk]
func handle_select() -> void:
	# dont allow selecting if the diskholder is closed or is empty
	if closed:
		return
	
	# if the player is holding an item
	var inventory: Inventory = GlobalVariables.player.inventory


	match selectable_component.interaction_index:
		0:
			# find equippable item
			var item: DiskItem
			var equipped: Array = inventory.get_items().filter(func(x: Item): return x is DiskItem and x.is_equipped)
			if !equipped.is_empty():
				item = equipped[0]
			else:
				return
			insert_disk(item)
		1:
			retrieve_disk(inventory)


	selectable_component.switch_interaction_label()

## Called when the Open button is clicked
func _on_open_close_opened() -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(disk_mesh, "position", Vector3(0, 0, 0), 0.5)
	tween.parallel().tween_property(disk_body, "position", Vector3(0, 0, 0), 0.5)
	closed = false
	selectable_component.can_be_selected = true
	diskholder_opened.emit(self.name)

## Called when the Close button is clicked
func _on_open_close_closed() -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(disk_mesh, "position", Vector3(0, 0, -0.7), 0.5)
	tween.parallel().tween_property(disk_body, "position", Vector3(0, 0, -0.7), 0.5)
	closed = true
	selectable_component.can_be_selected = false
	diskholder_closed.emit(self.name)


func has_disk() -> bool:
	return disk_item != null

## Called when a player uses a disk into an empty diskholder
func insert_disk(disk: DiskItem):
	disk_item = disk
	insert_marker.add_child(disk.scene.instantiate())
	GlobalEventManager.disk_inserted.emit(disk_item)
	GlobalVariables.inventory.remove_item(disk_item)

## Called when player a clicks on the diskholder while a disk exist
func retrieve_disk(inventory: Inventory):
	if disk_item != null:
		inventory.add_item(disk_item)
		disk_item = null
		insert_marker.get_child(0).queue_free()
		return true

## This function is called when the player presses the force toggle button.
## Very ambiguous, but it works
func force_toggle():
	$Open_Close.toggle()

func _on_play_play_btn_pressed() -> void:
	if !has_disk():
		return
	if !closed:
		force_toggle()
		await get_tree().create_timer(0.5).timeout

	await get_tree().create_timer(0.2).timeout
	disk_played.emit(disk_item)
