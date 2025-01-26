extends Area3D

@export var sun: DirectionalLight3D
@export var ambient: AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_enter)

func _on_enter(body):
	sun.light_energy = 0
	ambient.play()