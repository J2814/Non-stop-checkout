extends Control
@onready var master_slider = get_node("SettingsButton/settings_menu/MasterSlider")
@onready var setting_window = get_node("SettingsButton/settings_menu")
@onready var menu_music = get_node("/root/AudioManager/Ambient/MainMenuMusic")
@onready var setting_exit = get_node("SettingsButton/settings_menu")
func _ready() -> void:
	menu_music.play()
	setting_window.hide()
	pass


func _on_close_game_pressed() -> void:
	AudioManager.click_sound()
	Global.wait(4)
	get_tree().quit()


func _on_play_pressed() -> void:
	AudioManager.click_sound()
	ScoreManager.reset_score()
	Global.HandOccupied = false
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
	setting_exit.show()

func _on_settings_exit_button_pressed() -> void:
	setting_exit.hide()
