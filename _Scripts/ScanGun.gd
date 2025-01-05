extends Node3D

@onready var mouse_pressed :Sprite3D= $MousePressed
@onready var mouse_not_pressed :Sprite3D = $MouseNotPressed
@export var ready_to_scan_pos :Vector3
@export var offscreen_pos :Vector3

func _ready() -> void:
	mouse_not_pressed.visible = true
	mouse_pressed.visible = false
	Global.scan_barcode.connect(Scan)
	Global.take_item.connect(GetReady)
	pass

func _exit_tree() -> void:
	Global.scan_barcode.disconnect(Scan)
	Global.take_item.disconnect(GetReady)
	pass

func _process(delta: float) -> void:
	pass

func GetReady():
	var tween = create_tween()
	tween.tween_property(self, "position", ready_to_scan_pos, 0.15)

func Scan(pos :Vector3):
	var tween = create_tween()
	tween.tween_property(self, "position", pos, 0.1)
	tween.tween_property(self, "position", offscreen_pos, 0.2)
	pass


func _on_timer_timeout() -> void:
	if mouse_pressed.visible:
		mouse_pressed.visible = false
		mouse_not_pressed.visible = true
	else:
		mouse_pressed.visible = true
		mouse_not_pressed.visible = false
	pass # Replace with function body.
