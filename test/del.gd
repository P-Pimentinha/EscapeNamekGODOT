extends Node2D

#@export var frequency = 5
@export_range(0, 1000) var frequency: float = 10
@export_range(0, 1000) var amplitude: float = 10
var time = 0

func _physics_process(delta):
	time += delta
	var movement = cos(time*frequency) * amplitude
	print(movement)
	position.y += movement * delta
	position.x += 1
	


