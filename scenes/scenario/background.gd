extends ParallaxBackground

@onready var electric_floor_animation = $Floor/AnimatedSprite2D
@onready var islands_sprite_2d = $Islands
@onready var terrain_texture = $Floor/Sprite2D
@onready var storm_timer = $storm_timer
@onready var audio_thunder = $Audios/audio_thunder
@export var terrain: Texture
@export var level: int
const arr_thunderstorm_animations = ["last_cloud", "mid_cloud", "top_cloud"]


# Called when the node enters the scene tree for the first time.
func _ready():
	
	if level == 3:
		level_3_setup()
	enable_electric_floor_animation()
	storm_timer.wait_time = randf_range(0.5,2)
	terrain_texture.texture = terrain


func _on_storm_timer_timeout():
	audio_thunder.play()
	var random_thunderstorm_animation= randi_range(0,2)	
	$Clouds/AnimatedSprite2D.play(arr_thunderstorm_animations[random_thunderstorm_animation])
	storm_timer.wait_time = randf_range(1.5,2.4)
	storm_timer.start()
	

func enable_electric_floor_animation():
	if level and level == 2:
		electric_floor_animation.visible = true
		electric_floor_animation.play("default")
	else:
		electric_floor_animation.visible = false
		electric_floor_animation.stop()

func level_3_setup():
	islands_sprite_2d.visible = false
