extends Node
#это глобал скрипт, из item вызываю add_to_score, использую отрицательные значения чтобы убавить score

@export var current_score :float

func add_to_score(amount :float):
	current_score += amount
	
	if current_score < 0:
		Global.gameover.emit

func reset_score():
	current_score = 0
