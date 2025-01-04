extends Node3D
@onready var MenuLayer = get_node("/root/MainScene/Menu/MenuLayer")
@onready var BGM = get_node("/root/AudioManager/Ambient/BackgroundMusic")
func _ready() -> void:
	MenuLayer.visible = false
	BGM.play()

func _process(delta: float) -> void:
	if MenuLayer.visible:
		MenuLayer.visible = false


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ESC"):
		pause_game()
		


func pause_game():
	MenuLayer.visible = true
	get_tree().paused = true
