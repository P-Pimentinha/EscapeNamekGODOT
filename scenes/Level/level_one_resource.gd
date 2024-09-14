extends Resource
class_name LevelOneScoreResource

@export var min_score: int = 0
@export var lvl1_max_score: int = 30

var total_current_score: int = 0

func add_current_score(value: int):
	total_current_score += value


func reset_total_current_score():
	total_current_score = 0

