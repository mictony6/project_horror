extends Node3D

var closed: bool = true

@onready var disk_mesh: MeshInstance3D = $DiskholderMesh
@onready var selectable_component: Selectable = $DiskholderMesh/Selectable
@onready var insert_marker: Node3D = %InsertMarker

var disk_item: Item = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selectable_component.mesh_instance = disk_mesh
	selectable_component.select = handle_select

	# close the diskholder when the game starts
	_on_open_close_closed()


func handle_select() -> void:
	# dont allow selecting if the diskholder is closed or is empty
	if closed:
		return
	
	# if the player is holding an item
	var inventory: Inventory = GlobalVariables.player.inventory


	match selectable_component.interaction_index:
		0:
			# find equippable item
			var item: Item
			var equipped: Array = inventory.get_items().filter(func(x: Item): return x.is_disk and x.is_equipped)
			if !equipped.is_empty():
				item = equipped[0]
			else:
				return
			insert_disk(item)
		1:
			retrieve_disk(inventory)


	selectable_component.switch_interaction_label()

# when its opened, the diskholder can be selected
func _on_open_close_opened() -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(disk_mesh, "position", Vector3(0, 0, 0), 0.5)
	closed = false
	selectable_component.can_be_selected = true

# when its closed, the diskholder cannot be selected
func _on_open_close_closed() -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(disk_mesh, "position", Vector3(0, 0, -0.7), 0.5)
	closed = true
	selectable_component.can_be_selected = false

func has_disk() -> bool:
	return disk_item != null

func insert_disk(disk: Item):
	disk_item = disk
	disk_item.is_equipped = false
	insert_marker.add_child(disk.scene.instantiate())

func retrieve_disk(inventory: Inventory):
	if disk_item != null:
		inventory.add_item(disk_item)
		disk_item = null
		insert_marker.get_child(0).queue_free()
		return true