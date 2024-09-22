extends State

const PROJECTILE_SCENE = preload ("res://scenes/Enemies/projectiles/projectile.tscn")
@onready var marker_2d: Array = [$"../../Marker2D", $"../../Marker2D2", $"../../Marker2D3"]
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var hoverboard_sprite = $"../../hoverboard_sprite"
#@onready var timer_egergy_strike: Timer = Timer.new()
#@onready var timer_projectiles: Timer = Timer.new()
@onready var enemy_one = $"../.."
@onready var timer_projectiles: Timer = Timer.new()
@onready var texture_progress_bar = $"../../TextureProgressBar"


var spawn_counter: int = 1
var spawn_location_dictionary: Dictionary = {
	1:0,
	2:1,
	3:1,
	4:2,
	5:1,
	6:2,
	7:1,
	8:1,
	9:0,
	10:1,
	11:2,
	12:1,
	13:2,
	14:1,
	15:0,
	16:0,
	17:1,
	18:1,
	19:2,
	20:1,
	21:2,
	22:1,
	23:1,
	24:0,
	25:1,
}

func Enter():
	animated_sprite_2d.position = Vector2(16,16)
	animated_sprite_2d.play("reboot")
	hoverboard_sprite.play("reboot")
	timer_settings()
	timer_projectiles.timeout.connect(spawn_projectiles)
	texture_progress_bar.visible = false
	

func Update(_delta : float):
	pass
		

func Physics_Update(_delta : float):
	pass
	
	
func Exit():
	pass

func spawn_projectiles():
	#animated_sprite_2d.play("attack_1")
	var projectile = PROJECTILE_SCENE.instantiate() as Area2D
	var random_index = randi() % marker_2d.size()
	projectile.position = marker_2d[spawn_location_dictionary[spawn_counter]].position
	#projectile.connect("animation_finished", end_attack_animation)
	#projectile.animation_finished.connect(end_attack_animation)
	enemy_one.add_child(projectile)
	timer_projectiles.start()
	spawn_counter += 1
	

func timer_settings():
	add_child(timer_projectiles)
	timer_projectiles.one_shot = true
	timer_projectiles.autostart = false
	timer_projectiles.wait_time = 2.3
	timer_projectiles.start()
