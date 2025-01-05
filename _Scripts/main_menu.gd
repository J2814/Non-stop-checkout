extends Control
@onready var setting_window = get_node("SettingsButton/SettingsWindow")
@onready var menu_music = get_node("/root/AudioManager/Ambient/MainMenuMusic")
func _ready() -> void:
	menu_music.play()
	pass


func _on_close_game_pressed() -> void:
	AudioManager.click_sound()
	Global.wait(4)
	get_tree().quit()


func _on_play_pressed() -> void:
	AudioManager.click_sound()
	get_tree().paused = false
	menu_music.stop()
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")


func _on_play_mouse_entered() -> void:
	AudioManager.hover_sound()
func _on_close_game_mouse_entered() -> void:
	AudioManager.hover_sound()
func _on_settings_button_mouse_entered() -> void:
	AudioManager.hover_sound()


func _on_settings_button_pressed() -> void:
	setting_window.show()

func _on_settings_window_close_requested() -> void:
	setting_window.hide()
