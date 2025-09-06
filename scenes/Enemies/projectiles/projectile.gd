extends Area2D

@export var speed: int = 600
@export var score_to_be_taken: int = -5
@onready var sprite_2d = $Sprite2D
@onready var animated_sprite_2d = $AnimatedSprite2D
var direction: Vector2 = Vector2(-1,0)
var can_move = false
const X_DIRECTION: int = -1
const ANIMATION_TIME_VALUE = 1

signal animation_finished

func _ready():
	#var random_y_direction = randf_range(0.1,0.3)
	#direction = Vector2(X_DIRECTION, random_y_direction).normalized()
	projectile_animation()
	
	
	
func _physics_process(delta):
	move_projectile(delta)
	
func _on_body_entered(body):
	if body is PlayerMain:
		body.take_damage(-1)
		queue_free()
		

func move_projectile(delta):
	if can_move:
		position += direction * speed * delta
	
func projectile_animation():
	animated_sprite_2d.play()
	var tween= create_tween()
	tween.tween_property(animated_sprite_2d, "scale", Vector2(0.6,0.6),ANIMATION_TIME_VALUE)
	await tween.finished
	animation_finished.emit()
	can_move = true
	
#
func switch_textures():
	sprite_2d.visible = false
	animated_sprite_2d.visible = true
	animated_sprite_2d.play()
