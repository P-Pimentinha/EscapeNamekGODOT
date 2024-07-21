extends ParallaxBackground

#const BG_CLOUDS_THUNDER_1 = preload("res://assets/myImg/background/dark/thunderstorm/clouds/bg_clouds1.png")
#const BG_CLOUDS_THUNDER_2 = preload("res://assets/myImg/background/dark/thunderstorm/clouds/bg_clouds2.png")
#const BG_CLOUDS_THUNDER_3 = preload("res://assets/myImg/background/dark/thunderstorm/clouds/bg_clouds3.png")


@onready var storm_timer = $storm_timer
@onready var audion_thunder = $Audios/audion_thunder
const arr_thunderstorm_animations = ["last_cloud", "mid_cloud", "top_cloud"]

#var last_played_animation: int = 1

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
	var random_thunderstorm_animation= randi_range(0,2)	
	$Clouds/AnimatedSprite2D.play(arr_thunderstorm_animations[random_thunderstorm_animation])
	storm_timer.wait_time = randf_range(1.5,2.4)
	storm_timer.start()
	
