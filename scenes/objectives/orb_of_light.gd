extends Area2D

var max_offset = 10
var speed = 0.07
var original_position
var time_passed = 0
@onready var animated_sprite_2d = $AnimatedSprite2D


var array_of_possible_orbs : Array = [
	{"texture": "blue", "value_to_add": 2},
	{"texture": "black", "value_to_add": -3},
]

var selected_orb


func _ready():	
	instatiate_orb()

func instatiate_orb():
	var random_index = randi() % array_of_possible_orbs.size()
	selected_orb = array_of_possible_orbs[random_index]
	
	animated_sprite_2d.play(selected_orb["texture"])
	original_position = position

func _on_body_entered(body):
	body.take_damage(selected_orb["value_to_add"])
	queue_free()
