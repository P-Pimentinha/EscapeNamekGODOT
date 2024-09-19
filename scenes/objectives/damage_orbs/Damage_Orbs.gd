extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
#@onready var data_container = "res://scenes/objectives/damage_orbs/damage_orb_data_resource.tres"
const DAMAGE_ORB_DATA_RESOURCE = preload("res://scenes/objectives/damage_orbs/damage_orb_data_resource.tres")
signal apply_damage

var selected_orb: String

var array_of_possible_orbs : Array = [
	"black", "orange", "green", "blue" 
]

func _ready():	
	instanciate_orb()

func instanciate_orb():
	if !DAMAGE_ORB_DATA_RESOURCE.last_color_selected:
		#randomly selects the orb
		var random_index = randi() % array_of_possible_orbs.size()
		selected_orb = array_of_possible_orbs[random_index]
		#sets the texture
		animated_sprite_2d.play(selected_orb)
		DAMAGE_ORB_DATA_RESOURCE.last_color_selected = selected_orb
	else:
		var new_color = DAMAGE_ORB_DATA_RESOURCE.last_color_selected
		while new_color == DAMAGE_ORB_DATA_RESOURCE.last_color_selected:
			var random_index = randi() % array_of_possible_orbs.size()
			new_color = array_of_possible_orbs[random_index]
		DAMAGE_ORB_DATA_RESOURCE.last_color_selected = new_color
		selected_orb = new_color
		animated_sprite_2d.play(selected_orb)
		
		
	
	
func _on_body_entered(body):
	apply_damage.emit(selected_orb)
	queue_free()



#extends Node2D
#
#var colors = {"Blue": 0, "Black": 0, "Green": 0, "Orange": 0}
#var max_circles = 4
#var max_diff = 1  # Maximum allowed difference in counts between most and least used colors
#
## Color mapping to their actual Color values in Godot
#var color_map = {
	#"Blue": Color(0, 0, 1),
	#"Black": Color(0, 0, 0),
	#"Green": Color(0, 1, 0),
	#"Orange": Color(1, 0.5, 0)
#}
#
#func _ready():
	#spawn_circles()
#
#func spawn_circles():
	#for i in range(max_circles):
		#var selected_color = get_next_color()
		#spawn_circle_with_color(selected_color)
#
#func get_next_color() -> String:
	## Get the color usage counts sorted by how frequently they've been used
	#var sorted_colors = colors.keys()
	#sorted_colors.sort_custom(self, "_compare_color_usage")
#
	## Choose from the least used colors, considering the max_diff limit
	#var min_used = colors[sorted_colors[0]]
	#var eligible_colors = []
	#for color in sorted_colors:
		#if colors[color] - min_used <= max_diff:
			#eligible_colors.append(color)
#
	## Randomly select from eligible colors
	#var random_index = randi() % eligible_colors.size()
	#var selected_color = eligible_colors[random_index]
#
	## Update the count for the selected color
	#colors[selected_color] += 1
	#return selected_color
#
#func _compare_color_usage(color_a: String, color_b: String) -> int:
	#return colors[color_a] - colors[color_b]
#
#func spawn_circle_with_color(color_name: String):
	#var circle = CircleShape2D.new()
	#var color = color_map[color_name]
	#
	## Create the visual representation of the circle
	#var circle_instance = ColorRect.new()
	#circle_instance.rect_min_size = Vector2(50, 50)
	#circle_instance.color = color
	#add_child(circle_instance)
	#
	## Set random position or other properties for the circle
	#circle_instance.position = Vector2(randf_range(0, 500), randf_range(0, 500))

