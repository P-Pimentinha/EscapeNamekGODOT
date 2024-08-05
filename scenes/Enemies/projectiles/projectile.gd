extends Area2D

@export var speed: int = 500
@onready var sprite_2d = $Sprite2D
var direction: Vector2
var can_move = false
var X_DIRECTION: int = -1

signal animation_finished

func _ready():
	var random_y_direction = randf_range(0.1,0.3)
	direction = Vector2(X_DIRECTION, random_y_direction).normalized()
	projectile_animation()
	
	
	
func _physics_process(delta):
	projectile_direction(delta)
	
func _on_body_entered(body):
	if body is PlayerMain:
		print(body)
		

func projectile_direction(delta):
	if can_move:
		position += direction * speed * delta
	
func projectile_animation():
	var tween= create_tween()
	tween.tween_property(sprite_2d, "scale", Vector2(3,3), 1)
	await tween.finished
	animation_finished.emit()
	can_move = true
#
#
#extends Area2D
#
#@export var speed : int = 2000
#var direction: Vector2 = Vector2.UP
## Called when the node enters the scene tree for the first time.
#func _ready():
	#$Timer.set_wait_time(2)
	#$Timer.start()
	#
	#
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#position += direction * speed * delta
	#
#
#
#func _on_body_entered(body):
	#if "hit" in body:
		#body.hit()
	#queue_free()
	#
#
#
#func _on_timer_timeout():
	#queue_free()



