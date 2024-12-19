extends Node3D
class_name Flashlight
var is_on: bool = true
var spotlight: SpotLight3D
var omni_light: OmniLight3D

func _ready() -> void:
	spotlight = $MeshInstance3D/SpotLight3D
	omni_light = $MeshInstance3D/OmniLight3D
	toggle()


func toggle():
	is_on = !is_on
	if is_on:
		spotlight.light_energy = 5
		omni_light.light_energy = 0.5
	else:
		spotlight.light_energy = 0
		omni_light.light_energy = 0