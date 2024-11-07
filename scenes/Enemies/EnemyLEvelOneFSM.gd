extends State


#region Preload
const PROJECTILE_SCENE = preload("res://scenes/Enemies/projectiles/projectile.tscn")
const ENERGY_STRIKE_ZONE_SCENE = preload("res://scenes/obstacles/EnergyStrikeZone/energy_strike_zone.tscn")
#endregion
#region OnReady
@onready var marker_2d: Array = [$"../../Marker2D", $"../../Marker2D2", $"../../Marker2D3"]
@onready var enemy_sprite = $"../../AnimatedSprite2D"
@onready var hoverboard_sprite = $"../../hoverboard_sprite"
@onready var enemy_one = $"../.."
@onready var texture_progress_bar = $"../../TextureProgressBar"

@onready var timer_egergy_strike: Timer = Timer.new()
@onready var timer_projectiles: Timer = Timer.new()
#in between projectile spawn
@onready var timer_three_projectiles_spawns : Timer = Timer.new()
#before it spawns on the scene
@onready var timer_three_projectiles: Timer = Timer.new()
@onready var three_projectiles_logic = ThreeProjectilesLogic.new(marker_2d)
#endregion

#region Variables
const ENERGY_STRIKE_Y_POSITION = 560
#var timers = [timer_egergy_strike, timer_three_projectiles, three_projectiles_logic]

#endregion


#region Process
func Enter():
	set_scene_func()
	call_random_timer(projectile_timer, energy_strike_timer)
	
func Update(_delta: float):
	pass
		

func Physics_Update(delta: float):
	enemy_one.enemy_movement(delta)
	#delete
	#if Input.is_action_just_pressed("jump"):
		#spawn_three_projectiles()
		#
	
	
func Exit():
	pass

#endregion

#region EnemyAttacks
#region Projectiles
func spawn_projectiles(spawn_three: bool):
	#start animations
	enemy_sprite.play("attack_projectile")
	hoverboard_sprite.play("attack_2_projectile")
	#instantiate scene
	var projectile = PROJECTILE_SCENE.instantiate() as Area2D
	#adds the projectile to the scene
	enemy_one.add_child(projectile)
	#sets the position of the projectile
	var get_position_array = three_projectiles_logic.get_position_array()
	var random_index = randi() % get_position_array.size()
	projectile.position = get_position_array[random_index].position
	#removes the last spawn position
	three_projectiles_logic.remove_marker_from_array(random_index)
	#connects the signal from the projectile
	if !spawn_three:
		#connects the signal from the projectile
		projectile.animation_finished.connect(end_attack_animation)
		#resets the position array
		three_projectiles_logic.reset_array(marker_2d)
		call_random_timer(energy_strike_timer, three_projectiles_timer)
	
func spawn_three_projectiles():	
	if three_projectiles_logic.get_proj_counter() == 3:
		three_projectiles_logic.reset_counter()
		spawn_projectiles(false)
	else:
		timer_three_projectiles_spawns.start()
		three_projectiles_logic.add_one_to_counter()
		spawn_projectiles(true)
#endregion
	
#region EnergyStrike
func spawn_energy_strike():
	enemy_sprite.play("attack_1")
	hoverboard_sprite.play("attack_1_energystrike")
	var parent_node = enemy_one.get_node("%FloorBurningPosition")
	var position_node = enemy_one.get_node("%Player")
	var energy_strike_zone = ENERGY_STRIKE_ZONE_SCENE.instantiate() as Area2D
	energy_strike_zone.animation_finished_strike_zone.connect(end_attack_animation)
	var random_x_offset = randi_range(-120, 120)
	parent_node.add_child(energy_strike_zone)
	#energy_strike_zone.global_position.x = position_node.global_position.x + Vector2(random_x_offset,0)
	energy_strike_zone.global_position.x = position_node.global_position.x
	energy_strike_zone.global_position.y = ENERGY_STRIKE_Y_POSITION
	call_random_timer(projectile_timer, three_projectiles_timer)
#endregion
	
#region Timers
func projectile_timer():
	timer_projectiles.wait_time = 3
	timer_projectiles.start()
	
	
func energy_strike_timer():
	#var random_number = randf_range(10.0, 15.0)
	timer_egergy_strike.wait_time = 3
	timer_egergy_strike.start()
	
	
func three_projectiles_timer():
	timer_three_projectiles.wait_time = 3
	timer_three_projectiles.start()
	
	
func call_random_timer(timer_one, timer_two):
	var timers = [timer_one, timer_two]
	var random_index = randi() % timers.size()
	timers[random_index].call()
#endregion
	
func end_attack_animation():
	enemy_sprite.stop()
	enemy_sprite.play("default")
	hoverboard_sprite.stop()
	hoverboard_sprite.play("normal")


	
	
#endregion


#region SetSceneFunc
func set_scene_func():
	#sets 
	enemy_sprite.position = Vector2(0, 0)
	enemy_sprite.play("default")
	hoverboard_sprite.play("normal")
	initial_timer_settings()
	texture_progress_bar.visible = false

func initial_timer_settings():
	add_child(timer_egergy_strike)
	timer_egergy_strike.one_shot = true
	timer_egergy_strike.autostart = false
	timer_egergy_strike.wait_time = 2
	timer_egergy_strike.timeout.connect(spawn_energy_strike)
	#timer_egergy_strike.start()
	
	add_child(timer_projectiles)
	timer_projectiles.one_shot = true
	timer_projectiles.autostart = false
	timer_projectiles.wait_time = 6
	timer_projectiles.timeout.connect(spawn_projectiles.bind(false))
	#timer_projectiles.start()
	
	add_child(timer_three_projectiles)
	timer_three_projectiles.one_shot = true
	timer_three_projectiles.autostart = false
	timer_three_projectiles.wait_time = 3
	timer_three_projectiles.timeout.connect(spawn_three_projectiles)
	
	add_child(timer_three_projectiles_spawns)
	timer_three_projectiles_spawns.one_shot = true
	timer_three_projectiles_spawns.autostart = false
	timer_three_projectiles_spawns.wait_time = 1
	timer_three_projectiles_spawns.timeout.connect(spawn_three_projectiles)
	#timer_projectiles.start()
	
#endregion
	
	
