extends Control
class_name LoadingScreen
@onready var status_label: Label = %StatusLabel
@onready var level_name_label: Label = %LevelNameLabel
@onready var progress_bar: ProgressBar = %ProgressBar

func _ready() -> void:
    hide()

func set_progress(val: Variant):
    progress_bar.value = move_toward(progress_bar.value, val, 1.0)

func reset_progress():
    self.modulate.a = 1
    progress_bar.value = 0