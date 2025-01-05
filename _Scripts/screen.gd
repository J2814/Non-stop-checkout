extends Node3D
@onready var TotalLabel = $MeshInstance3D/SubViewport/Control/TotalLabel
@onready var RecentItemGoodLabel = $MeshInstance3D/SubViewport/Control/RecentItemGood
@onready var RecentItemBadLabel = $MeshInstance3D/SubViewport/Control/RecentItemBad

func _process(delta: float) -> void:
	TotalLabel.set_text("Total: \n" + str(ScoreManager.current_score) + '$')
	

func _ready() -> void:
	RecentItemBadLabel.visible = false
	RecentItemGoodLabel.visible = false
	ScoreManager.good_item.connect(GoodItem)
	ScoreManager.bad_item.connect(BadItem)

func _exit_tree() -> void:
	ScoreManager.good_item.disconnect(GoodItem)
	ScoreManager.bad_item.disconnect(BadItem)

func BadItem(item_name :String, price :float):
	RecentItemBadLabel.visible = true
	RecentItemGoodLabel.visible = false
	
	RecentItemBadLabel.set_text(item_name + "\n-" + str(price) + '$')
	pass

func GoodItem(item_name :String, price :float):
	RecentItemBadLabel.visible = false
	RecentItemGoodLabel.visible = true
	
	RecentItemGoodLabel.set_text(item_name + "\n+" + str(price) + '$')
	
	pass
