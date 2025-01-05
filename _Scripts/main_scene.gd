extends Node3D
@onready var button_layer = $Menu/buttonLayer
@onready var menu_layer = $Menu/MenuLayer
@onready var BGM = get_node("/root/AudioManager/Ambient/BackgroundMusic")

var elapsed_time :float = 0


var paused :bool = false
var gameover :bool = false

func _ready() -> void:
	Global.TryToAssignCamera()
	Global.gameover.connect(Gameover)
	#menu_layer.visible = false
	#button_layer.visible = false
	BGM.play()
	

func _exit_tree() -> void:
	Global.gameover.disconnect(Gameover)

func Gameover():
	gameover = true
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ESC"):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _process(delta: float) -> void:
	if !paused and !gameover:
		elapsed_time += delta
		ScoreManager.elapsed_time = elapsed_time
	
	#if menu_layer.visible:
	#	menu_layer.visible = false
	#if button_layer.visible:
	#	button_layer.visible = false

#func _input(event: InputEvent) -> void:
#	if Input.is_action_just_pressed("ESC"):
#		if get_tree().paused:
#			get_tree().paused = false
#		else:
#			pause_game()

#func pause_game():
#	print("ne igraem")
#	menu_layer.visible = true
#	button_layer.visible = true
#	get_tree().paused = true
