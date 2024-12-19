extends PanelContainer
class_name ItemSlot

@onready var texture_rect: TextureRect = %TextureRect

func set_item_to_display(item: Item):
	texture_rect.texture = item.icon;
