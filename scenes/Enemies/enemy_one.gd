extends CharacterBody2D
class_name EnemyOne

@export_enum("LevelOne", "LevelTwo") var level_to_load: String

# Variables to control the movement
var amplitude = 3 # The height of the wave
var frequency = 2 # How fast the wave oscillates

# Internal time tracker
var time = 0.0

# Initial y position to keep the wave relative to the starting point
var initial_y = 0.0

func _ready():
	# Store the initial y position
	initial_y = position.y

func enemy_movement(delta):
	# Increment time by the frame time
	time += delta
	
	# Calculate the new position
	var new_y = initial_y + amplitude * sin(frequency * time) # Oscillate relative to the initial y
	
	# Update the position
	position.y = new_y
