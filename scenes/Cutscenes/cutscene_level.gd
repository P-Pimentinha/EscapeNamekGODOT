extends Node2D


#Create 3 animations one after lvl1 one after lvl 2 and the final one ... play accordingly with the level

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if GameLevelController.current_level == 2:
		get_tree().change_scene_to_file("res://scenes/Level/level_2.tscn")
	elif GameLevelController.current_level == 3:
		get_tree().change_scene_to_file("res://scenes/Level/level_3.tscn") 
	elif GameLevelController.current_level == 4:
		pass
