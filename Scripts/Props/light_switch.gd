extends Node3D

@onready var selectable_component: Selectable = $Selectable
@onready var aniamtion_player: AnimationPlayer = $AnimationPlayer
var is_on: bool = false

func _ready() -> void:
	selectable_component.select = handle_select

func handle_select() -> void:
	is_on = !is_on
	if is_on:
		aniamtion_player.play("SwitchON")
	else:
		aniamtion_player.play("SwitchOFF")
	selectable_component.switch_interaction_label()
