extends Area3D
@export var environment: WorldEnvironment


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(player_inside)
	body_exited.connect(player_exit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func player_inside(body):
	environment.environment.fog_enabled = true
	environment.environment.fog_density = 0
	create_tween().tween_property(environment.environment, "fog_density", 0.005, 0.5)
func player_exit(body):
	
	await create_tween().tween_property(environment.environment, "fog_density", 0.0, 0.5).finished
	environment.environment.fog_enabled = false
