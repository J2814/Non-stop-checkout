extends Node3D

var last_mouse_position = Vector2.ZERO

@export var sway_amount :float = 0.005

func _ready() -> void:
	last_mouse_position = get_viewport().get_mouse_position()

func _process(delta: float) -> void:
	CameraSway(delta)

func CameraSway(deltaTime):
	var mouse_position = get_viewport().get_mouse_position()
	
	if last_mouse_position != Vector2.ZERO:
		var delta_position = mouse_position - last_mouse_position
		Rotation(delta_position, deltaTime)
	
	last_mouse_position = mouse_position

func Rotation(delta_position: Vector2, deltaTime: float):
	rotate(Vector3.LEFT, delta_position.y * sway_amount * deltaTime) 
	rotate(Vector3.DOWN, delta_position.x * sway_amount * deltaTime) 
	pass
