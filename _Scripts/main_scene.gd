extends Node3D
@onready var MenuLayer = get_node("/root/MainScene/Menu/MenuLayer")
@onready var BGM = get_node("/root/AudioManager/Ambient/BackgroundMusic")

var elapsed_time :float = 0


var paused :bool = false
var gameover :bool = false

func _ready() -> void:
	Global.TryToAssignCamera()
	Global.gameover.connect(Gameover)
	MenuLayer.visible = false
	BGM.play()
	

func _exit_tree() -> void:
	Global.gameover.disconnect(Gameover)

func Gameover():
	gameover = true

func _process(delta: float) -> void:
	if !paused and !gameover:
		elapsed_time += delta
		ScoreManager.elapsed_time = elapsed_time
	
	if MenuLayer.visible:
		MenuLayer.visible = false



func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ESC"):
		pause_game()
		

func pause_game():
	MenuLayer.visible = true
	get_tree().paused = true
	
