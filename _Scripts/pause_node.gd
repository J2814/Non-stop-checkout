extends Node


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ESC"):
		get_viewport().set_input_as_handled()
		get_tree().paused = false
