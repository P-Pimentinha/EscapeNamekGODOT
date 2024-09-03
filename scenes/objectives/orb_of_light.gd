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
	#var get_last_used_orb = get_parent().level_resources.last_selected_orb
	var random_index = randi() % array_of_possible_orbs.size()
	selected_orb = array_of_possible_orbs[random_index]
	#while selected_orb == get_last_used_orb:
		#random_index = randi() % array_of_possible_orbs.size()
		#selected_orb = array_of_possible_orbs[random_index]
	
	#get_parent().level_resources.last_selected_orb = selected_orb
	animated_sprite_2d.play(selected_orb["texture"])
	original_position = position

func _physics_process(delta):
	pass
	#time_passed += delta
	#if time_passed >= speed:
		#time_passed = 0
		#var offset_x = randf_range(-max_offset, max_offset)
		#var offset_y = randf_range(-max_offset, max_offset)
		#position = original_position + Vector2(offset_x, offset_y)

func _on_body_entered(body):
	ScoreGlobals.add_current_score(selected_orb["value_to_add"])
	queue_free()
