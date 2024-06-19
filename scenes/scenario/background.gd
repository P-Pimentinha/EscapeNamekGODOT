extends ParallaxBackground

#const BG_CLOUDS_THUNDER_1 = preload("res://assets/myImg/background/dark/thunderstorm/clouds/bg_clouds1.png")
#const BG_CLOUDS_THUNDER_2 = preload("res://assets/myImg/background/dark/thunderstorm/clouds/bg_clouds2.png")
#const BG_CLOUDS_THUNDER_3 = preload("res://assets/myImg/background/dark/thunderstorm/clouds/bg_clouds3.png")


@onready var storm_timer = $storm_timer
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
#
#var storm_textures: Array = [
	#{"texture": BG_CLOUDS_THUNDER_1, "audio" : "hello"},
	#{"texture": BG_CLOUDS_THUNDER_2, "audio" : "hello"},
	#{"texture": BG_CLOUDS_THUNDER_3, "audio" : "hello"},
#]

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_storm_timer_timeout():
	audio_stream_player_2d.play(0.2)
	$Clouds/AnimatedSprite2D.play()
