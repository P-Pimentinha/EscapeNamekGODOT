extends State

const PROJECTILE_SCENE = preload ("res://scenes/Enemies/projectiles/projectile.tscn")
const BURNING_FLOOR = preload("res://scenes/obstacles/burning_floor/burning_floor.tscn")
const ENERGY_STRIKE_ZONE = preload("res://scenes/obstacles/EnergyStrikeZone/energy_strike_zone.tscn")
@onready var marker_2d: Array = [$"../../Marker2D", $"../../Marker2D2", $"../../Marker2D3"]
@onready var fire_timer = $"../../FireTimer"
@onready var projectile_timer = $"../../ProjectileTimer"
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var timer_egergy_strike: Timer = Timer.new()
@onready var timer_projectiles: Timer = Timer.new()
@onready var enemy_one = $"../.."


func Enter():
	animated_sprite_2d.play("default")
	timer_settings()
	timer_egergy_strike.timeout.connect(spawn_energy_strike)
	timer_projectiles.timeout.connect(spawn_projectiles)
	#fire_timer.start()
	#projectile_timer.start()
	

func Update(_delta : float):
	pass
		

func Physics_Update(_delta : float):
	pass
	
	
func Exit():
	pass


func spawn_projectiles():
	animated_sprite_2d.play("attack_1")
	var projectile = PROJECTILE_SCENE.instantiate() as Area2D
	var random_index = randi() % marker_2d.size()
	projectile.position = marker_2d[random_index].position
	#projectile.connect("animation_finished", end_attack_animation)
	projectile.animation_finished.connect(end_attack_animation)
	enemy_one.add_child(projectile)
	

#func spawn_fire():
	#var node_to_add_child = get_node("%Obstacles")
	#var ground_fire_position = get_parent().get_node("FloorBurningPosition")
	#var ground_fire = ENERGY_STRIKE_ZONE.instantiate() as Area2D
	#ground_fire.position = ground_fire_position.global_position
	#node_to_add_child.add_child(ground_fire)
	
func spawn_energy_strike():
	var parent_node = enemy_one.get_node("%FloorBurningPosition")
	var position_node = enemy_one.get_node("%Player")
	var energy_strike_zone = ENERGY_STRIKE_ZONE.instantiate() as Area2D
	var random_x_offset = randi_range(-120,120)
	parent_node.add_child(energy_strike_zone)
	energy_strike_zone.global_position = position_node.global_position + Vector2(random_x_offset,0)
	

func end_attack_animation():
	animated_sprite_2d.stop()
	animated_sprite_2d.play("default")


func timer_settings():
	add_child(timer_egergy_strike)
	timer_egergy_strike.one_shot = true
	timer_egergy_strike.autostart = false
	timer_egergy_strike.wait_time = 5.0
	timer_egergy_strike.start()
	
	add_child(timer_projectiles)
	timer_projectiles.one_shot = true
	timer_projectiles.autostart = false
	timer_projectiles.wait_time = 1.0
	timer_projectiles.start()
