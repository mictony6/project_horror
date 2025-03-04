extends Node3D

signal solution1_solved


func _on_solution_1_on_power_on() -> void:
	solution1_solved.emit()
