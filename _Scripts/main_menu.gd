extends Control

@onready var menu_music = get_node("/root/AudioManager/Ambient/MainMenuMusic")
func _ready() -> void:
	menu_music.play()
	pass


func _on_close_game_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	get_tree().paused = false
	menu_music.stop()
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")
