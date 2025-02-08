extends Control
class_name QuickSelectUI

enum {
	RIGHT = 1,
	LEFT = -1
}

@onready var timer: Timer = $Timer
@onready var name_label: Label = $VBoxContainer/Label
@onready var scroll_bar: HScrollBar = %ScrollBar
@onready var item_list: ScrollContainer = %ItemList
@onready var hbox: HBoxContainer = %ItemList.get_child(0)
@export var scroll_item_scene: PackedScene


var accumulator: int = 0
var scroll_threshold: int = 4
var target_scroll: int = 0

var max_size: int = 0
var SEPARATION_VALUE = 25
var SCROLL_AMOUNT = 100 + SEPARATION_VALUE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	set_process_input(false)
	await GlobalVariables.player_ready
	set_process_input(true)
	hide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			scroll(LEFT)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			scroll(RIGHT)

func _process(delta: float) -> void:
	item_list.scroll_horizontal = lerp(item_list.scroll_horizontal, target_scroll, 0.25)

func scroll(factor: int):

	show()
	timer.stop()
	timer.start()


	max_size = GlobalVariables.inventory.size() + 1 # add one for the unequip scroll item
	scroll_bar.max_value = GlobalVariables.inventory.size()


	for child in hbox.get_children():
		if child.name == "None":
			continue
		else:
			child.queue_free()

	if GlobalVariables.player.inventory.size() == 0:
		name_label.text = "Inventory Empty"

		return
	
	for item in GlobalVariables.inventory.get_items():
		var instance: ScrollItem = scroll_item_scene.instantiate()
		instance.set_item(item)
		hbox.add_child(instance)

	
	accumulator += factor
	if accumulator >= scroll_threshold:
		select_next()
		accumulator = 0

	elif accumulator <= -scroll_threshold:
		select_previous()
		accumulator = 0

	GlobalEventManager.item_used.emit(scroll_bar.value - 1)
	if target_scroll == 0:
		name_label.text = "Remove"
	else:
		name_label.text = GlobalVariables.inventory.get_items()[scroll_bar.value - 1].name

	
func select_next():
	target_scroll += SCROLL_AMOUNT
	target_scroll = wrapi(target_scroll, 0, (max_size) * SCROLL_AMOUNT)
	scroll_bar.value = target_scroll / SCROLL_AMOUNT

func select_previous():
	target_scroll -= SCROLL_AMOUNT
	target_scroll = wrapi(target_scroll, 0, (max_size) * SCROLL_AMOUNT)

	target_scroll %= max_size * SCROLL_AMOUNT
	scroll_bar.value = target_scroll / SCROLL_AMOUNT


func _on_timer_timeout():
	hide()