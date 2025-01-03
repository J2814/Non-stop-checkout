extends Node3D

var item_scenes: Array = []

@onready var timer :Timer = $Timer

var allowSpawn: bool = false

func _init():
	PopulateItemArray()
	
	

func _ready() -> void:
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
		instance.global_position = Vector3(-5, 0, randf_range(-1, 1))

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		spawn_random_object() 


func _on_timer_timeout() -> void:
	if allowSpawn:
		spawn_random_object()
		timer.start()
	
