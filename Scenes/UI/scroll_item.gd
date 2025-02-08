extends PanelContainer
class_name ScrollItem

@export var item: Item

func set_item(item: Item):
	item = item
	$TextureRect.texture = item.icon
