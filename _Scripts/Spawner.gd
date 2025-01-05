extends Node3D

#var item_scenes: Array = []

@onready var item_scenes = [
	preload("res://Prefabs/Products/cereal_item.tscn")
]
@onready var debugLabel :Label = $Control/Label
@onready var timer :Timer = $Timer
var allowSpawn: bool = false
@export var timerstages = [3.0, 2.6, 2.4, 2.2, 2.0, 1.8, 1.6]
@export var spawn_point_x :float
@export var spawn_point_y :float
@export var spawn_point_z_range :Vector2

func _init():
	pass
	
	

func _ready() -> void:
	#PopulateItemArray()
	Global.gameover.connect(StopSpawning)
	spawn_random_object()
	StartSpawnning()
	Global.diff = 0

func _exit_tree() -> void:
	Global.gameover.disconnect(StopSpawning)

func StopSpawning():
	allowSpawn = false
	timer.paused = true

func StartSpawnning():
	allowSpawn = true
	timer.start()

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		spawn_random_object() 
		
func spawn_random_object():
	if item_scenes.is_empty():
		print("No objects to spawn!")
		debugLabel.set_text("No objects to spawn!")
		AudioManager.play_beep()
		return
	else:
		pass
		#AudioManager.play_beep()
	var random_index = randi() % item_scenes.size()
	var scene_path = item_scenes[random_index]
	if scene_path:
		var instance = scene_path.instantiate()
		add_child(instance)
		instance.global_position = Vector3(spawn_point_x, spawn_point_y, randf_range(spawn_point_z_range.x, spawn_point_z_range.y))
		
	#var scene = load(scene_path)  
	#if scene:
		#var instance = scene.instantiate()
		#add_child(instance)
		#instance.global_position = Vector3(spawn_point_x, spawn_point_y, randf_range(spawn_point_z_range.x, spawn_point_z_range.y))
		
func difficulty():
	var objectcoeff = Global.objscanneddelt/10
	#print("шзнх")
	if objectcoeff == 1:
		Global.diff +=1
		Global.diff = clamp(Global.diff, 0, 6)
		objectcoeff = 0
		Global.objscanneddelt = 0
		print(objectcoeff)
		

func _process(_delta: float) -> void:
	difficulty()

func _on_timer_timeout() -> void:
	if allowSpawn:
		spawn_random_object()
		timer.wait_time = timerstages[Global.diff]
		timer.start()
	#print('s' ,Global.objscanneddelt)
	#print('d',Global.diff)
