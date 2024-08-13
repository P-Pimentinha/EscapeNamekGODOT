extends State

const PROJECTILE_SCENE = preload ("res://scenes/Enemies/projectiles/projectile.tscn")
@onready var marker_2d: Array = [$"../../Marker2D", $"../../Marker2D2", $"../../Marker2D3"]
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
#@onready var timer_egergy_strike: Timer = Timer.new()
#@onready var timer_projectiles: Timer = Timer.new()
@onready var enemy_one = $"../.."
@onready var timer_projectiles: Timer = Timer.new()

func Enter():
	animated_sprite_2d.play("reboot")
	timer_settings()
	timer_projectiles.timeout.connect(spawn_projectiles)
	

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
	projectile.position = marker_2d[random_index].position
	#projectile.connect("animation_finished", end_attack_animation)
	#projectile.animation_finished.connect(end_attack_animation)
	enemy_one.add_child(projectile)
	

func timer_settings():
	add_child(timer_projectiles)
	timer_projectiles.one_shot = true
	timer_projectiles.autostart = false
	timer_projectiles.wait_time = 1.0
	timer_projectiles.start()
