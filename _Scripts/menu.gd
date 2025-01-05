extends Control




func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	AudioManager.BGM.stop()


func _on_continue_pressed() -> void:
	get_tree().paused = false
