extends Node3D
class_name LevelManager

@onready var loading_screen: LoadingScreen = $LoadingScreen
@onready var level_container: Node3D = $LevelContainer
var loading: bool = false
var level_path: String
var level_instance: Level = null

# no usage yet but could be helpful
signal level_loaded(scene: PackedScene)
signal level_ready()

func _ready() -> void:
	GlobalVariables.level_manager = self
	load_level("res://Scenes/Levels/Hub.tscn")

func _process(delta: float) -> void:
	if loading:
		
		var progress: Array = []
		var status = ResourceLoader.load_threaded_get_status(level_path, progress)
		match status:
			ResourceLoader.THREAD_LOAD_IN_PROGRESS:
				loading_screen.set_progress(progress[0] * 100.0)
			ResourceLoader.THREAD_LOAD_LOADED:
				var scene: PackedScene = ResourceLoader.load_threaded_get(level_path)
				change_scene(scene)
				loading = false
				await level_ready
				await fade_out_loading_screen()
				loading_screen.hide()
				set_process(false)


	else:
		loading_screen.set_progress(100.0)
		if level_instance and level_instance.is_node_ready() and $UiRoot.is_node_ready() and loading_screen.progress_bar.value == 100:
			level_ready.emit()


func unload_level():
	if level_instance != null:
		level_instance.queue_free()
		level_instance = null

func load_level(_level_path: String):
	set_process(true)
	level_path = _level_path
	loading_screen.reset_progress()
	loading_screen.show()

	if ResourceLoader.has_cached(level_path):
		var scene: PackedScene = ResourceLoader.load(level_path, "PackedScene", ResourceLoader.CACHE_MODE_REUSE)
		loading = false
		level_loaded.emit(scene)
		change_scene(scene)
		return

	ResourceLoader.load_threaded_request(level_path, "PackedScene", true)
	loading = true

func change_scene(scene: PackedScene):
	unload_level()
	level_instance = scene.instantiate()
	level_container.add_child(level_instance)

func fade_out_loading_screen():
	var tween: Tween = create_tween()
	var final_val: Color = loading_screen.modulate
	final_val.a = 0
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.tween_property(loading_screen, "modulate", final_val, 1.0)
	return tween.finished