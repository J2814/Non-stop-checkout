extends Node
@onready var button_click = get_node("InteractionSounds/Click")
@onready var button_hover = get_node("InteractionSounds/Hover")
@onready var loose = $InteractionSounds/Loose
@onready var missed_item = $InteractionSounds/MissedItem
@onready var take_item = $InteractionSounds/TakeItem
@onready var BGM = get_node("Ambient/BackgroundMusic")
@onready var Beep = get_node("InteractionSounds/Scan")
@onready var MenuMusic = get_node("Ambient/MainMenuMusic")
@onready var sfx_value: float = 0.5
@onready var music_value: float = 0.5
@onready var master_value: float = 0.5

func play_beep():
	Beep.play()

func click_sound():
	button_click.play()

func hover_sound():
	button_hover.play()

func loose_sound():
	loose.play()

func take_sound():
	take_item.play()

func missed_sound():
	missed_item.play()

func _ready() -> void:
	
	pass
