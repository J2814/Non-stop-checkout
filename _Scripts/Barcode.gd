extends Node3D
@onready var hitBox: Area3D = $Area3D
signal scanned

var animate :bool = false

var defaultScale

func _ready() -> void:
	defaultScale = self.scale
	pass # Replace with function body.

func _process(delta: float) -> void:
	
	pass

func AnimateBarcode():
	
	var tween = create_tween()
	tween.tween_property(self, "scale", defaultScale * 1.1, 0.125)
	tween.tween_property(self, "scale", defaultScale, 0.125)


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
				Global.scan_barcode.emit(result.position)
				pass


func _on_barcode_anim_timer_timeout() -> void:
	if animate:
		AnimateBarcode()
	pass # Replace with function body.
