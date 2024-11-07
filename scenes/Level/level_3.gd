extends MainRootScene


@onready var player = %Player
@onready var camera_2d = $Camera2D
@onready var ground = $Ground
@onready var hud = $Control/hud
@onready var restart_button = $Control/GameOver
@onready var orb_spawn_timer = $Timers/Orb_Spawn_TImer
@onready var marker_position_arr: Array = [$Camera2D/OrbSpawnMarker, $Camera2D/OrbSpawnMarker2, $Camera2D/OrbSpawnMarker3, $Camera2D/OrbSpawnMarker4]
#@onready var floor_burning_position = $Camera2D/FloorBurningPosition
#delete
@onready var damage_orbs = $DamageOrbs
@onready var enemy_one = $Camera2D/EnemyOne

#orbs var
const DAMAGE_ORBS = preload("res://scenes/objectives/damage_orbs/Damage_Orbs.tscn")
#var last_spawned_orb
var get_enemy_damage_function

const PLAYER_START_POSITION := Vector2i(100, 528)
const CAM_START_POS := Vector2i(576, 324)
const MIN_CAM_SPEED: int = PlayerMain.MIN_SPEED

var screen_size: Vector2i

#region Process
func _ready():
	super()
	set_scene()


func _physics_process(delta):
	##update ground position
	if GameControl.is_game_running:
		update_camera_position(delta)
		update_ground_position()
	pause_game(hud)
	game_over()
	#change_background_music()

func set_scene():
	screen_size = get_window().size
	new_game(scene_new_game)
	restart_button.get_node("Button").pressed.connect(restart)
	hud.start_game_hud.connect(start_game)
	hud.unpause_game_hud.connect(unpause_game.bind(hud))
	get_enemy_damage_function = enemy_one.get_node("FSM/LevelThree")
	get_enemy_damage_function.connect("life_reached_zero", player_wins)
	get_enemy_damage_function.connect("life_reached_100", game_over)

#endregion
	
##orb logic
#region Orb Logic
func spawn_damage_orbs():
	#selects random spawn position
	var random_index = randi() % marker_position_arr.size()
	var spawn_marker = marker_position_arr[random_index] as Marker2D
	#instantiates the orb, sets the position & connects the signal
	var damage_orb = DAMAGE_ORBS.instantiate() as Area2D
	damage_orb.position = spawn_marker.global_position
	#scene + signal + function to be called
	damage_orb.connect("apply_damage", get_enemy_damage_function.check_if_orb_can_damage)
	add_child(damage_orb)
	
func _on_orb_spawn_t_imer_timeout():
	spawn_damage_orbs()
#endregionaaaaa
	

#region background and camera func
func update_camera_position(delta):
	camera_2d.position.x += MIN_CAM_SPEED * delta

func _on_despawn_area_2d_area_entered(area):
	area.queue_free()

func update_ground_position():
	if camera_2d.position.x - ground.position.x > screen_size.x * 1.5:
		ground.position.x += screen_size.x
#endregion

#region Game State
#game state
func scene_new_game():
	restart_button.hide()
	player.position = PLAYER_START_POSITION
	player.velocity = Vector2i(0, 0)
	camera_2d.position = CAM_START_POS
	ground.position = Vector2i(0, 0)

func start_game():
	get_tree().paused = false
	hud.hide_hud()
	orb_spawn_timer.start()
	GameControl.game_running()

func player_wins():
	GameLevelController.set_current_level(3)
	get_tree().change_scene_to_file("res://scenes/Cutscenes/cutscene_level.tscn")
	
	
#!!!!!when player changes scene check if player_took_damage var is false or true
func game_over():
	if player.player_took_damage:
		restart_button.show()
		GameControl.game_over()
		get_tree().paused = true
#endregion


func _on_area_2d_area_entered(area):
	area.queue_free()
