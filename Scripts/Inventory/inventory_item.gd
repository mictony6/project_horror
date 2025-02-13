class_name InventoryItem
extends RefCounted

var _item: Item
var is_equipped: bool = false

func _init(item: Item) -> void:
    self._item = item

func get_item():
    return _item
