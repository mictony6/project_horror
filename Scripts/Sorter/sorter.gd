extends Node3D
class_name Sorter

@export var sorter_id: String = "sorter_1"
var num_of_slots: int
@onready var diskholders: Array[Diskholder] = $Diskholders.get_children() as Array[Diskholder]


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	for diskholder in diskholders:
		diskholder.diskholder_opened.connect(on_diskholder_opened)


func on_diskholder_opened(name: String) -> void:
	# closes any open diskholder
	for dh in diskholders:
		if dh.name != name and !dh.closed:
			dh.force_toggle()
