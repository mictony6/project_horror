extends Node3D
class_name ToolManager
@onready var player: Player = get_parent().get_parent()
@export var animation_player: AnimationPlayer
@onready var hit_particles: GPUParticles3D = %HitParticles
var item_held: Item

func _ready() -> void:
	GlobalEventManager.item_used.connect(hold_item)
	process_mode = Node.PROCESS_MODE_ALWAYS


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack") and is_holding_item():
		use_held_item()


func hold_item(id: int):
	var item: Item = player.inventory.get_items()[id]
	if item == item_held:
		unequip_item()
		return

	if is_holding_item():
		unequip_item() # Unequip current item if holding any
	var scene = item.scene.instantiate()
	item_held = item
	add_child(scene)

func unequip_item():
	item_held = null
	get_child(0).queue_free()


func use_held_item():
	if is_holding_item():
		animation_player.play("use_item")

func is_holding_item() -> bool:
	return item_held != null

func _on_area_3d_area_entered(area: Area3D) -> void:
	pass
	# var interactable: Interactable = area.get_parent()
	# await interactable.handle_interaction(item_held)

	# item_held.uses -= 1

	# if item_held.name == "Knife":
	# 	hit_particles.global_position = global_position
	# 	hit_particles.restart()
	# 	hit_particles.emitting = true

		
func _process(delta: float) -> void:
	if is_holding_item() and item_held.uses <= 0:
		player.inventory.remove_item(item_held)
		item_held = null
		get_child(0).queue_free()
