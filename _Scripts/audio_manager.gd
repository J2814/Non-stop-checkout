extends Node

@onready var BGM = get_node("Ambient/BackgroundMusic")
@onready var Beep = get_node("InteractionSounds/Scan")


func play_beep():
	Beep.play()
	

#func 

func _ready() -> void:
	
	pass
