extends Node2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer

##@export var frequency = 5
#@export_range(0, 1000) var frequency: float = 10
#@export_range(0, 1000) var amplitude: float = 10
#var time = 0
#
#func _physics_process(delta):
	#time += delta
	#var movement = cos(time*frequency) * amplitude
	#print(movement)
	#position.y += movement * delta
	#position.x += 1

func _ready():
	Engine.max_fps = 60
	animation_player.play("CutSceneTest")	

func animation_one():
	animated_sprite_2d.play("first")

func animation_two(number: int):
	animated_sprite_2d.play("second")


func stop_all_animations():
	animated_sprite_2d.stop()
