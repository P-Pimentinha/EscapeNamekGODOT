extends Node
class_name ThreeProjectilesLogic

var projectiles_counter: int = 1
var spawn_position_array: Array
var copy_spawn_position_array: Array

# _init() constructor function to enforce argument passing
func _init(position_array: Array):
	spawn_position_array = position_array.duplicate()
	
	
func get_proj_counter():
	return projectiles_counter

func add_one_to_counter():
	projectiles_counter += 1

func reset_counter():
	projectiles_counter = 1

func get_position_array():
	return spawn_position_array

func remove_marker_from_array(index_marker):
	spawn_position_array.remove_at(index_marker)

func reset_array(position_array: Array):
	spawn_position_array = position_array.duplicate()
