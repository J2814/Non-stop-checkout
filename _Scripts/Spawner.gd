extends Node3D

var item_scenes: Array = []

@onready var timer :Timer = $Timer
var allowSpawn: bool = false
@export var timerstages = [2.0, 1.5, 1.0, 0.5]
@export var spawn_point_x :float
@export var spawn_point_y :float
@export var spawn_point_z_range :Vector2

func _init():
	PopulateItemArray()
	
	

func _ready() -> void:
	spawn_random_object()
	StartSpawnning()

func StartSpawnning():
	allowSpawn = true

	timer.start()

func PopulateItemArray():
	var dir = DirAccess.open("res://Prefabs/Products")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tscn"):
				item_scenes.append("res://Prefabs/Products/" + file_name)
			file_name = dir.get_next()
		print("Loaded scenes: ", item_scenes)


func spawn_random_object():
	if item_scenes.is_empty():
		print("No objects to spawn!")
		return
	var random_index = randi() % item_scenes.size()
	var scene_path = item_scenes[random_index]
	var scene = load(scene_path)  
	if scene:
		var instance = scene.instantiate()
		add_child(instance)
		instance.global_position = Vector3(spawn_point_x, spawn_point_y, randf_range(spawn_point_z_range.x, spawn_point_z_range.y))
		
func difficulty():
	var objectcoeff = Global.objscanneddelt/5
	#print("шзнх")
	if objectcoeff == 1:
		Global.diff +=1
		Global.diff = clamp(Global.diff, 0, 3)
		objectcoeff = 0
		Global.objscanneddelt = 0
		print(objectcoeff)
		
func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		spawn_random_object() 
func _process(_delta: float) -> void:
	difficulty()

func _on_timer_timeout() -> void:
	if allowSpawn:
		spawn_random_object()
		timer.wait_time = timerstages[Global.diff]
		timer.start()
	#print('s' ,Global.objscanneddelt)
	#print('d',Global.diff)
