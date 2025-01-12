extends PanelContainer
class_name CdSlot

@onready var texture_rect: TextureRect = $CdDisplay/TextureRect
@onready var label: Label = $CdDisplay/Label
@export var item: Item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if item:
		texture_rect.texture = item.icon
		label.text = item.name

func _on_button_pressed() -> void:
	print(item)

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	var slot: CdSlot = data
	var can_drop: bool = slot.item != null and slot.item is Item
	return can_drop

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var slot: CdSlot = data
	var previous_item = item
	set_item(slot.item)
	data.set_item(previous_item)


func set_item(new_item: Item) -> void:
	item = new_item
	texture_rect.texture = item.icon
	label.text = item.name
