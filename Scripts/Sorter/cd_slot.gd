extends PanelContainer

@onready var button: MenuButton = $VBoxContainer/Button
@onready var label: Label = $VBoxContainer/Label
@export var item: Item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if item:
		button.icon = item.icon
		label.text = item.name

func _on_button_pressed() -> void:
	print(item)
