extends Node3D
@onready var screentext =get_node("MeshInstance3D/SubViewport/Label")
func _process(delta: float) -> void:
	screentext.set_text(str(clamp(ScoreManager.current_score, 0, 255)) + '$')
