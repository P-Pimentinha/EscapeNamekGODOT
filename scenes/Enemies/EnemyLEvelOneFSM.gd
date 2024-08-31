extends State

const PROJECTILE_SCENE = preload ("res://scenes/Enemies/projectiles/projectile.tscn")
const ENERGY_STRIKE_ZONE = preload("res://scenes/obstacles/EnergyStrikeZone/energy_strike_zone.tscn")
const ENERGY_STRIKE_Y_POSITION = 560
@onready var marker_2d: Array = [$"../../Marker2D", $"../../Marker2D2", $"../../Marker2D3"]
@onready var enemy_sprite = $"../../AnimatedSprite2D"
@onready var hoverboard_sprite = $"../../hoverboard_sprite"
@onready var timer_egergy_strike: Timer = Timer.new()
@onready var timer_projectiles: Timer = Timer.new()
@onready var enemy_one = $"../.."


func Enter():
	enemy_sprite.position = Vector2(0,0)
	enemy_sprite.play("default")
	hoverboard_sprite.play("normal")
	initial_timer_settings()
	timer_egergy_strike.timeout.connect(spawn_energy_strike)
	timer_projectiles.timeout.connect(spawn_projectiles)

	

func Update(_delta : float):
	pass
		

func Physics_Update(delta : float):
	enemy_one.enemy_movement(delta)
	
	
func Exit():
	pass


func spawn_projectiles():
	enemy_sprite.play("attack_projectile")
	hoverboard_sprite.play("attack_2_projectile")
	var projectile = PROJECTILE_SCENE.instantiate() as Area2D
	var random_index = randi() % marker_2d.size()
	projectile.position = marker_2d[random_index].position
	#projectile.connect("animation_finished", end_attack_animation)
	projectile.animation_finished.connect(end_attack_animation)
	enemy_one.add_child(projectile)
	energy_strike_timer()
	
	
func spawn_energy_strike():
	enemy_sprite.play("attack_1")
	hoverboard_sprite.play("attack_1_energystrike")
	var parent_node = enemy_one.get_node("%FloorBurningPosition")
	var position_node = enemy_one.get_node("%Player")
	var energy_strike_zone = ENERGY_STRIKE_ZONE.instantiate() as Area2D
	energy_strike_zone.animation_finished_strike_zone.connect(end_attack_animation)
	var random_x_offset = randi_range(-120,120)
	parent_node.add_child(energy_strike_zone)
	#energy_strike_zone.global_position.x = position_node.global_position.x + Vector2(random_x_offset,0)
	energy_strike_zone.global_position.x = position_node.global_position.x
	energy_strike_zone.global_position.y = ENERGY_STRIKE_Y_POSITION
	
	projectile_timer()
	

func end_attack_animation():
	enemy_sprite.stop()
	enemy_sprite.play("default")
	hoverboard_sprite.stop()
	hoverboard_sprite.play("normal")


func initial_timer_settings():
	add_child(timer_egergy_strike)
	timer_egergy_strike.one_shot = true
	timer_egergy_strike.autostart = false
	timer_egergy_strike.wait_time = 2
	timer_egergy_strike.start()
	
	add_child(timer_projectiles)
	timer_projectiles.one_shot = true
	timer_projectiles.autostart = false
	timer_projectiles.wait_time = 6
	#timer_projectiles.start()

func projectile_timer():
	timer_projectiles.wait_time = 3
	timer_projectiles.start()

func energy_strike_timer():
	#var random_number = randf_range(10.0, 15.0)
	timer_egergy_strike.wait_time = 3
	timer_egergy_strike.start()
