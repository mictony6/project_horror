extends RigidBody3D

@onready var selectable_component: Selectable = $MeshInstance3D/Selectable
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selectable_component.select = read_contents
	Dialogic.signal_event.connect(_on_dialogic_signal)

func read_contents():
	Dialogic.start("notes and clues")

func _on_dialogic_signal(arg: String):
	match arg:
		"note":
			print("Nice")