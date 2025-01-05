extends Node
#это глобал скрипт, из item вызываю add_to_score, использую отрицательные значения чтобы убавить score

signal score_updated
signal bad_item(name :String, price :float)
signal good_item(name :String, price :float)

@export var scanned_items :int = 0
@export var current_score :float = 0
@export var maximum_money :float = 0

var elapsed_time :float 

func add_to_score(amount :float):
	current_score += amount
	
	if current_score < 0:
		print("fuck")
		Global.gameover.emit()
		
	
	if current_score > maximum_money:
		maximum_money = current_score
	
	if amount > 0:
		scanned_items += 1
	
	score_updated.emit()
	
	

func reset_score():
	current_score = 0
