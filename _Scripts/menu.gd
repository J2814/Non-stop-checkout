extends Control

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	Global.HandOccupied = false
	AudioManager.BGM.stop()
	AudioManager.click_sound()


func _on_continue_pressed() -> void:
	AudioManager.click_sound()
	get_tree().paused = false
