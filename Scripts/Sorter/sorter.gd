extends Node3D
class_name Sorter

@export var sorter_id: String = "sorter_1"
var num_of_slots: int
@onready var diskholders: Array = $Diskholders.get_children()


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	for diskholder in diskholders:
		diskholder.diskholder_opened.connect(on_diskholder_opened)
		diskholder.disk_played.connect(on_disk_played)


func on_diskholder_opened(name: String) -> void:
	# closes any open diskholder
	for dh in diskholders:
		if dh.name != name and !dh.closed:
			dh.force_toggle()

func on_disk_played(disk_item: DiskItem) -> void:
	var level_scene: PackedScene = disk_item.level_scene
	get_tree().change_scene_to_packed(level_scene)