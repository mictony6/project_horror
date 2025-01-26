extends Node

var player: Player
var inventory: Inventory
var level_manager: LevelManager

var can_open_inventory = true
    
@onready var voices = DisplayServer.tts_get_voices_for_language("en")
