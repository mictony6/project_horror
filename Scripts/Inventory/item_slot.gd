extends PanelContainer
class_name ItemSlot

@onready var button: Button = %Button

var _id: int


func set_item_to_display(item: Item, id: int):
	_id = id
	button.icon = item.icon;
	button.button_down.connect(_on_button_down)

func _on_button_down():
	GlobalEventManager.item_used.emit(_id)