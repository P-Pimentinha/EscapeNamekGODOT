extends Area2D

@export var speed: int = 800
var direction: Vector2


func _ready():
	var random_float_value = randf_range(0,0.4)
	direction = Vector2(-1, random_float_value).normalized()
	
func _physics_process(delta):
	projectile_direction(delta)
	
func _on_body_entered(body):
	if body is PlayerMain:
		print(body)
		

func projectile_direction(delta):
	## Update position
	position += direction * speed * delta
	
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



