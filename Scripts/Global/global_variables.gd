extends Node
signal player_ready


var _player: Player
var player: Player:
    get():
        return _player
    set(value):
        _player = value
        player_ready.emit()

var inventory: Inventory = Inventory.new();

var level_manager: LevelManager

var can_open_inventory = true

@onready var voices = DisplayServer.tts_get_voices_for_language("en")

func _ready() -> void:
    GlobalEventManager.item_pickup.connect(inventory.add_item)