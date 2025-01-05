extends Node3D



var default_pos :Vector3 = self.position
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ScoreManager.score_updated.connect(ScoreUpdateAnim)
	pass # Replace with function body.

func _exit_tree() -> void:	
	ScoreManager.score_updated.disconnect(ScoreUpdateAnim)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func ScoreUpdateAnim():
	var totaltween = create_tween()
	
	var pop_pos :Vector3 = default_pos + Vector3(0,-0.15,0)
	totaltween.tween_property(self, "position", pop_pos, 0.075)
	totaltween.tween_property(self, "position", default_pos, 0.075)
	pass
