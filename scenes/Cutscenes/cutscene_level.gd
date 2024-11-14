extends Node2D

@onready var level_2_animated_sprite: AnimatedSprite2D = $Level2/Level2_animatedSprite
@onready var level_3_animated_sprite = $Level3/level3_animatedSprite
@onready var level_4_animated_sprite = $Level4/level4_animatedSprite

@onready var body_1 = $Level2/Body1
@onready var animation_player = $AnimationPlayer

var can_close = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if GameLevelController.current_level == 2:
		animation_player.play("Level_2_Intro")
	elif GameLevelController.current_level == 3:
		level_3_animated_sprite.visible = true
		level_3_animated_sprite.play("default")
	elif GameLevelController.current_level == 4:
		can_close = true
		level_4_animated_sprite.visible = true
		level_4_animated_sprite.play("default")
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_close and Input.is_action_just_pressed("close"):
		get_tree().quit()


func play_animation(animation_to_play: String):
	level_2_animated_sprite.stop()
	level_2_animated_sprite.play(animation_to_play)

func advance_to_level2():
	get_tree().change_scene_to_file("res://scenes/Level/level_2.tscn")

func advance_to_level3():
	get_tree().change_scene_to_file("res://scenes/Level/level_3.tscn")


func _on_level_3_animated_sprite_animation_finished():
	advance_to_level3()
