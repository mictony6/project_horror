extends RefCounted
class_name Inventory


var _content: Array[Item];


func add_item(item: Item):
    _content.append(item)

func remove_item(item: Item):
    _content.erase(item)
    
func get_items() -> Array[Item]:
    return _content;

func size():
    return _content.size()

func get_item(idx: int):
    if idx > get_items().size():
        return null
    return get_items()[idx]
