extends Control
@onready var menu_layer = get_node("MenuLayer")
@onready var button_layer = get_node("buttonLayer")
func _ready() -> void:
	menu_layer.hide()
	button_layer.hide()

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	Global.HandOccupied = false
	AudioManager.BGM.stop()
	AudioManager.click_sound()


func _on_continue_pressed() -> void:
	print("igraem")
	AudioManager.click_sound()
	get_tree().paused = false
	
