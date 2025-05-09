extends Node3D
class_name Flashlight
var is_on: bool = true
@export var spotlight: SpotLight3D
@export var omni_light: OmniLight3D
@export var animation_player: AnimationPlayer

@export var energy = 2.5

func _ready() -> void:
	# spotlight = $MeshInstance3D/SpotLight3D
	# omni_light = $MeshInstance3D/OmniLight3D
	toggle()


func toggle():
	is_on = !is_on
	if is_on:
		animation_player.play("FlashLightUp")
		spotlight.light_energy = energy
		omni_light.light_energy = energy * 0.25
	else:
		animation_player.play("FlashLightDown")
		spotlight.light_energy = 0
		omni_light.light_energy = 0
