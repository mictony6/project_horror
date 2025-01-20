extends PanelContainer
class_name ItemSlot

@onready var button: Button = %Button

var _id: int


func set_item_to_display(item: Item, id: int):
	_id = id
	button.icon = item.icon;


func _on_button_button_down() -> void:
	GlobalEventManager.item_used.emit(_id)
