extends Node3D
class_name Flashlight
var is_on: bool = true
var spotlight: SpotLight3D
var omni_light: OmniLight3D
@export var animation_player: AnimationPlayer

func _ready() -> void:
	spotlight = $MeshInstance3D/SpotLight3D
	omni_light = $MeshInstance3D/OmniLight3D
	toggle()


func toggle():
	is_on = !is_on
	if is_on:
		animation_player.play("FlashLightUp")
		spotlight.light_energy = 5
		omni_light.light_energy = 0.5
	else:
		animation_player.play("FlashLightDown")
		spotlight.light_energy = 0
		omni_light.light_energy = 0
