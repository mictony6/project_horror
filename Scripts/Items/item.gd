extends Resource
class_name Item

@export var name: String
@export var scene: PackedScene
@export var icon: Texture2D

@export_group("Tool Handling")
@export var position: Vector3
@export var rotation: Vector3