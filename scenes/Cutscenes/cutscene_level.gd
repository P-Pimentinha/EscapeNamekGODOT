extends Node2D

@onready var level_2_animated_sprite: AnimatedSprite2D = $Level2/Level2_animatedSprite
@onready var body_1 = $Level2/Body1
@onready var animation_player = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	if GameLevelController.current_level == 2:
		animation_player.play("Level_2_Intro")
	else:
		pass

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


func play_animation(animation_to_play: String):
	level_2_animated_sprite.stop()
	level_2_animated_sprite.play(animation_to_play)

func advance_to_level2():
	get_tree().change_scene_to_file("res://scenes/Level/level_2.tscn")
