extends Node


#func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("ESC"):
		#get_viewport().set_input_as_handled()
		#get_tree().paused = false
		
@onready var button_layer = get_node("/root/Container/ViewPort/Menu/buttonLayer")
@onready var menu_layer = get_node("/root/Container/ViewPort/Menu/MenuLayer")
@onready var BGM = get_node("/root/AudioManager/Ambient/BackgroundMusic")



func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ESC"):
		if get_tree().paused:
			get_tree().paused = false
			menu_layer.visible = false
			button_layer.visible = false
		else:
			pause_game()

func pause_game():
	print("ne igraem")
	menu_layer.visible = true
	button_layer.visible = true
	get_tree().paused = true
