extends Resource
class_name DamageOrbsData

var last_color_selected: String

var colors: Dictionary = {"blue": 0, "black": 0, "green": 0, "orange": 0}
var max_orbs: int = 3
var max_diff: int = 2

func get_next_color() -> String:
	# Get the color usage counts sorted by how frequently they've been used
	var sorted_colors = colors.keys()
	sorted_colors.sort_custom(_compare_color_usage)

	# Choose from the least used colors, considering the max_diff limit
	var min_used = colors[sorted_colors[0]]
	var eligible_colors = []
	for color in sorted_colors:
		if colors[color] - min_used <= max_diff:
			eligible_colors.append(color)

	# Randomly select from eligible colors
	var random_index = randi() % eligible_colors.size()
	var selected_color = eligible_colors[random_index]

	# Update the count for the selected color
	colors[selected_color] += 1
	return selected_color

func _compare_color_usage(color_a: String, color_b: String) -> int:
	return colors[color_a] - colors[color_b]
