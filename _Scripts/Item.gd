extends Node3D


var price :float = 0.99;

var objscanned = 1;

enum itemState {InHand, Scanned, NotScanned}

var current_state = itemState.NotScanned

var last_mouse_position : Vector2

@onready var camera = get_node("/root/MainScene/Camera3D")

@onready var hitBox: Area3D = $Area3D

@onready var deathTimer: Timer = $DeathTimer

@export var spawn_rotations : Array[Vector3]

var isGrounded :bool = false

func _ready() -> void:
	RandomizeRotation()
	
	pass

func _physics_process(delta: float) -> void:
	if current_state == itemState.NotScanned:
		if (!isGrounded):
			GoToGround(delta)


func _process(_delta: float):
	if current_state == itemState.NotScanned:
		if (isGrounded):
			MoveOnConveyorBelt(_delta)



	if current_state == itemState.InHand:
		RotateInHand(_delta)
	

func RandomizeRotation():
	if (spawn_rotations.size() > 0):
		
		rotation_degrees = spawn_rotations[randi_range(0, spawn_rotations.size() - 1)]
	
	rotate_y(randf_range(deg_to_rad(0), deg_to_rad(360)))
	
	

func MoveOnConveyorBelt(delta: float):
	position.x += (Global.CurrentSpeed + Global.diff/2) * delta

func GoToGround(delta: float):
	position.y -= 10 * delta


func RotateInHand(deltaTime):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_position = get_viewport().get_mouse_position()
		
		if last_mouse_position != Vector2.ZERO:
			var delta_position = mouse_position - last_mouse_position
			Rotation(delta_position, deltaTime)
		
		last_mouse_position = mouse_position

func Rotation(delta_position: Vector2, deltaTime: float):
	global_rotate(Vector3.RIGHT, delta_position.y * Global.Rotation_speed * deltaTime) 
	global_rotate(Vector3.UP, delta_position.x * Global.Rotation_speed * deltaTime) 
	pass



func ChangeState(newstate: itemState):
	current_state = newstate
	
	if newstate == itemState.InHand:
		Global.take_item.emit()
		Global.HandOccupied = true
	
	if newstate == itemState.Scanned:
		Global.HandOccupied = false
	
	pass

func MoveToInHand():
	var tween = create_tween()
	tween.tween_property(self, "position", Global.InHandPosition, 0.15)
	
	pass

func RemoveFromHand():
	ChangeState(itemState.Scanned)
	
	Global.objscanneddelt +=1
	Global.objscanned +=1
	
	var tween = create_tween()
	tween.tween_property(self, "position", Global.ScannedPosition, 0.15)
	tween.tween_property(self, "scale", 0.001 * Vector3(1,1,1), 0.3)
	deathTimer.start()

func _input(event):
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			last_mouse_position = get_viewport().get_mouse_position()
	
	if Global.HandOccupied:
		return
	if current_state != itemState.NotScanned:
		return
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			TakeItem(event)

func TakeItem(event):
	var ray_origin = Global.camera.global_transform.origin  # Camera's position
	var ray_direction = Global.camera.project_ray_normal(event.position)  # Ray direction from mouse position
	
	var ray_query = PhysicsRayQueryParameters3D.create(ray_origin, ray_origin + ray_direction * 1000)
	ray_query.collide_with_areas = true
	
	var space_state = get_world_3d().direct_space_state
	var result = space_state.intersect_ray(ray_query)
	if result and result.collider == hitBox:
		ChangeState(itemState.InHand)
		MoveToInHand()


func _on_barcode_scanned() -> void:
	AudioManager.play_beep()
	RemoveFromHand()


func _on_death_timer_timeout() -> void:
	self.queue_free()


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.get_parent().name == "Ground":
		isGrounded = true
		pass
