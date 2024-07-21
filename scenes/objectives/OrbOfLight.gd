extends Area2D

@onready var sprite_2d = $Sprite2D

const ORB_32_RED = preload("res://assets/art/objectives/orbs/orb32Red.png")
const ORB_32_YELLOW = preload("res://assets/art/objectives/orbs/orb32Yellow.png")
const ORB_32_BLUE = preload("res://assets/art/objectives/orbs/orb32yblue.png")

var array_of_possible_orbs : Array = [
	{"texture": ORB_32_BLUE, "value_to_add": 2},
	{"texture": ORB_32_YELLOW, "value_to_add": 4},
	{"texture": ORB_32_RED, "value_to_add": -3},
]

var selected_orb

func _ready():
	var random_index = randi() % array_of_possible_orbs.size()
	selected_orb = array_of_possible_orbs[random_index]
	sprite_2d.texture = selected_orb["texture"]

func _on_body_entered(body):
	ScoreGlobals.add_current_score(selected_orb["value_to_add"])
	queue_free()
