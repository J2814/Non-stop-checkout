extends Node3D

@export var item_name :String
@export var price :float = 0.99;

var objscanned = 1;

enum itemState {InHand, Scanned, NotScanned}

var current_state = itemState.NotScanned

var last_mouse_position : Vector2
var mouse_velocity: Vector2 = Vector2.ZERO
var inertia_velocity: Vector2 = Vector2.ZERO
var inertia_damping: float = 10 # Controls how quickly the inertia slows down

@onready var camera = get_node("/root/MainScene/Camera3D")

@onready var hitBox: Area3D = $Area3D

@onready var deathTimer: Timer = $DeathTimer

@export var spawn_rotations : Array[Vector3]

var mouse_release_flag :bool = false

var isGrounded :bool = false

var scored :bool = false

func _ready() -> void:
	RandomizeRotation()
	
	pass

func _physics_process(delta: float) -> void:
	if current_state == itemState.NotScanned:
		if (!isGrounded):
			GoToGround(delta)
	
	
	


func _process(delta: float):
	if current_state == itemState.NotScanned:
		if (isGrounded):
			MoveOnConveyorBelt(delta)
	
	if current_state == itemState.InHand:
		RotateInHand(delta)
		ApplyInertia(delta)
	

func RandomizeRotation():
	if (spawn_rotations.size() > 0):
		
		rotation_degrees = spawn_rotations[randi_range(0, spawn_rotations.size() - 1)]
	
	rotate_y(randf_range(deg_to_rad(0), deg_to_rad(360)))
	
	

func MoveOnConveyorBelt(delta: float):
	position.x += (Global.CurrentSpeed + Global.diff/2) * delta

func GoToGround(delta: float):
	position.y -= 10 * delta


func RotateInHand(deltaTime):
	var mouse_position = get_viewport().get_mouse_position()
	var delta_position = mouse_position - last_mouse_position
	mouse_velocity = delta_position / deltaTime
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		
		
		if last_mouse_position != Vector2.ZERO:
			
			Rotation(delta_position, deltaTime)
			
			
		
		#inertia_velocity = Vector2.ZERO
		last_mouse_position = mouse_position
	else:
		pass
		#last_mouse_position = Vector2.ZERO
	
	if Input.is_action_just_released("click"):
		if mouse_velocity != Vector2.ZERO:
				inertia_velocity = mouse_velocity / 100
				
				mouse_velocity = Vector2.ZERO

func ApplyInertia(deltaTime):
	#print(inertia_velocity.length())
	if inertia_velocity.length() > 0.001:  # Threshold to stop unnecessary small movements
		Rotation(inertia_velocity, deltaTime)
		# Gradually reduce inertia velocity using linear interpolation
	if inertia_velocity != Vector2.ZERO:
		inertia_velocity = inertia_velocity.lerp(Vector2.ZERO, inertia_damping * deltaTime)
	


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
	if !scored:
		ScoreManager.add_to_score(price)
		scored = true
	PrepareToDeath()

func PrepareToDeath():
	var tween = create_tween()
	tween.tween_property(self, "position", Global.ScannedPosition, 0.15)
	tween.tween_property(self, "scale", 0.001 * Vector3(1,1,1), 0.3)
	deathTimer.start()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			mouse_release_flag = true
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
		
	if area.get_parent().name == "Border":
		PrepareToDeath()
		if !scored:
			ScoreManager.add_to_score(-price)
			scored = true

	
