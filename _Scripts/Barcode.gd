extends Node3D
@onready var hitBox: Area3D = $Area3D
signal scanned

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass
	
func _input(event):
	
	if !Global.HandOccupied:
		return
		
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			var ray_origin = Global.camera.global_transform.origin  # Camera's position
			var ray_direction = Global.camera.project_ray_normal(event.position)  # Ray direction from mouse position
			var ray_query = PhysicsRayQueryParameters3D.create(ray_origin, ray_origin + ray_direction * 1000)
			ray_query.collide_with_areas = true
			var space_state = get_world_3d().direct_space_state
			var result = space_state.intersect_ray(ray_query)
			
			if result and result.collider == hitBox:
				scanned.emit()
				pass
