extends Node

const MIN_SCORE: int = 0
const MAX_SCORE: int = 100

var total_current_score: int = 0



func add_current_score(value: int):
	total_current_score += value


func reset_total_current_score():
	total_current_score = 0

