extends Area3D
@export var environment: WorldEnvironment

var tween: Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(player_inside)
	body_exited.connect(player_exit)
	tween = create_tween()

func player_inside(body):
	environment.environment.fog_enabled = true
	environment.environment.fog_density = 0
	tween.kill()
	tween = create_tween()
	tween.tween_property(environment.environment, "fog_density", 0.005, 0.5)
func player_exit(body):
	tween.kill()
	tween = create_tween()
	await tween.tween_property(environment.environment, "fog_density", 0.0, 0.5).finished
	environment.environment.fog_enabled = false
