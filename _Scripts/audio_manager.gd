extends Node
@onready var button_click = get_node("InteractionSounds/Click")
@onready var button_hover = get_node("InteractionSounds/Hover")
@onready var BGM = get_node("Ambient/BackgroundMusic")
@onready var Beep = get_node("InteractionSounds/Scan")
@onready var MenuMusic = get_node("Ambient/MainMenuMusic")

func play_beep():
	Beep.play()
	

func click_sound():
	button_click.play()

func hover_sound():
	button_hover.play()

func _ready() -> void:
	
	pass
