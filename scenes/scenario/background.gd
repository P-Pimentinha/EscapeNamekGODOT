extends ParallaxBackground

#const BG_CLOUDS_THUNDER_1 = preload("res://assets/myImg/background/dark/thunderstorm/clouds/bg_clouds1.png")
#const BG_CLOUDS_THUNDER_2 = preload("res://assets/myImg/background/dark/thunderstorm/clouds/bg_clouds2.png")
#const BG_CLOUDS_THUNDER_3 = preload("res://assets/myImg/background/dark/thunderstorm/clouds/bg_clouds3.png")


@onready var storm_timer = $storm_timer
@onready var audion_thunder = $Audios/audion_thunder


var last_played_animation: int = 1

#var storm_textures: Array = [
	#{"texture": BG_CLOUDS_THUNDER_1, "audio" : "hello"},
	#{"texture": BG_CLOUDS_THUNDER_2, "audio" : "hello"},
	#{"texture": BG_CLOUDS_THUNDER_3, "audio" : "hello"},
#]

# Called when the node enters the scene tree for the first time.
func _ready():
	storm_timer.wait_time = randf_range(0.5,2)
	
#func _physics_process(delta):
	#if Input.is_action_just_pressed("jump"):
		#audion_thunder.play()

func _on_storm_timer_timeout():
	
	audion_thunder.play()
	if last_played_animation == 1:
		thunder_one_animation()
	elif last_played_animation == 2:
		thunder_two_animation()
	else:
		thunder_three_animation()
	
	last_played_animation = randi_range(1,3)	
	storm_timer.wait_time = randf_range(1.5,2.4)
	storm_timer.start()
	

func thunder_one_animation():
	
	$Clouds/AnimatedSprite2D.play("last_cloud")

func thunder_two_animation():

	$Clouds/AnimatedSprite2D.play("mid_cloud")

func thunder_three_animation():
	
	$Clouds/AnimatedSprite2D.play("top_cloud")
