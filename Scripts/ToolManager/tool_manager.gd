extends Node3D
class_name ToolManager

@export var player: Player
@export var selector: RayCast3D
@export var animation_player: AnimationPlayer
@onready var hit_particles: GPUParticles3D = %HitParticles
var item_held: Item

func _ready() -> void:
	GlobalEventManager.item_used.connect(hold_item)
	GlobalEventManager.disk_inserted.connect(on_disk_inserted)
	process_mode = Node.PROCESS_MODE_ALWAYS


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			use_held_item()


func hold_item(id: int):
	var item: Item = player.inventory.get_items()[id]
	item.is_equipped = true
	# if the item clicked is the same as the one held, unequip it

	if is_holding_item():
		if item == item_held:
			unequip_item()
			return
		else:
			unequip_item()
			
	var scene = item.scene.instantiate()
	item_held = item
	add_child(scene)

func unequip_item():
	item_held.is_equipped = false
	item_held = null
	get_child(0).queue_free()

func use_held_item():

	# TODO: Replace with tween
	if !is_holding_item():
		return
	
	animation_player.play("use_item")
		

func is_holding_item() -> bool:
	return item_held != null


func _process(delta: float) -> void:

	if is_holding_item() and item_held.uses <= 0:
		player.inventory.remove_item(item_held)
		item_held = null
		get_child(0).queue_free()


# event handler for when a disk is inserted
func on_disk_inserted(disk: DiskItem):
	player.inventory.remove_item(disk)
	unequip_item()