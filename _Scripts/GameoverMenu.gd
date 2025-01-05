extends Control

@onready var gameover_menu = $MenuLayer
@onready var survived_time_label = $MenuLayer/SurvivedTimeLabel

func _ready() -> void:
	Global.gameover.connect(ShowGameover)
	gameover_menu.visible = false

func _exit_tree() -> void:
	Global.gameover.disconnect(ShowGameover)

func _process(delta: float) -> void:
	pass

func ShowGameover():
	AudioManager.loose_sound()
	
	gameover_menu.visible = true
	UpdateSurvivedTime(ScoreManager.elapsed_time)
	AudioManager.BGM.stop()

func UpdateSurvivedTime(val :float):
	val = snapped(val, 0.01)
	
	survived_time_label.set_text("You survived for: " + str(val) + " seconds")

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	AudioManager.BGM.stop()
	AudioManager.click_sound()


func _on_play_again_pressed() -> void:
	AudioManager.click_sound()
	ScoreManager.reset_score()
	Global.HandOccupied = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")
	AudioManager.click_sound()
