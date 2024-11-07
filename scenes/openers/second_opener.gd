extends Node2D

@onready var animation = $animation

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	skip_scene()


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/Level/level_one.tscn")

func skip_scene():
	if Input.is_action_just_pressed("jump"):
		get_tree().change_scene_to_file("res://scenes/Level/level_one.tscn")
