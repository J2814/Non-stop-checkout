extends Node3D
@onready var screentext =get_node("MeshInstance3D/SubViewport/Label")
func _process(delta: float) -> void:
	screentext.set_text(str(clamp(ScoreManager.current_score, 0, 255)) + '$')
	
	Global.gameover.emit()


func _ready() -> void:
	Global.gameover.connect(ShowUI)

func _exit_tree() -> void:
	Global.gameover.disconnect(ShowUI)




func ShowUI():
	pass
