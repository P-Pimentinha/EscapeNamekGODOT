extends Area2D

@export var speed: int = 500
@onready var sprite_2d = $Sprite2D
@onready var animated_sprite_2d = $AnimatedSprite2D
var direction: Vector2 = Vector2(-1,0)
var can_move = false
var X_DIRECTION: int = -1

signal animation_finished

func _ready():
	#var random_y_direction = randf_range(0.1,0.3)
	#direction = Vector2(X_DIRECTION, random_y_direction).normalized()
	projectile_animation()
	
	
	
func _physics_process(delta):
	move_projectile(delta)
	
func _on_body_entered(body):
	if body is PlayerMain:
		print(body)
		

func move_projectile(delta):
	if can_move:
		position += direction * speed * delta
	
func projectile_animation():
	animated_sprite_2d.play()
	var tween= create_tween()
	tween.tween_property(animated_sprite_2d, "scale", Vector2(0.6,0.6),1)
	await tween.finished
	animation_finished.emit()
	can_move = true
	
#
func switch_textures():
	sprite_2d.visible = false
	animated_sprite_2d.visible = true
	animated_sprite_2d.play()




