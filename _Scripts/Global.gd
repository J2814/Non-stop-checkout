extends Node


@export var CurrentSpeed :float = 2

@export var InHandPosition :Vector3 = Vector3(0,1.5,0.5)

@export var ScannedPosition :Vector3 = Vector3(3,0,0)

var HandOccupied :bool

var camera :Camera3D

var Rotation_speed = 0.6

func _init() -> void:
	pass

func _ready() -> void:
	camera = get_tree().root.get_node("MainScene/Camera3D")
	pass
