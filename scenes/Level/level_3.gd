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
var last_spawned_orb
var get_gamage_orb_callBack_func

const PLAYER_START_POSITION := Vector2i(100, 528)
const CAM_START_POS := Vector2i(576, 324)
const MIN_CAM_SPEED: int = PlayerMain.MIN_SPEED

var screen_size: Vector2i

func _ready():
	super()
	screen_size = get_window().size
	new_game(scene_new_game)
	restart_button.get_node("Button").pressed.connect(restart)
	hud.start_game_hud.connect(start_game)
	hud.unpause_game_hud.connect(unpause_game.bind(hud))
	
#delete
	get_gamage_orb_callBack_func = enemy_one.get_node("FSM/LevelThree")
	#damage_orbs.apply_damage.connect()
	
	#object.signal_name.connect(method_name.bind([extra, arguments]))

func _physics_process(delta):
	##update ground position
	if GameControl.is_game_running:
		update_camera_position(delta)
		update_ground_position()
	pause_game(hud)
	player_wins()
	game_over()
	#change_background_music()
	
##orb logic
func spawn_damage_orbs():
	#selects random orb spawn position
	var random_index = randi() % marker_position_arr.size()
	var spawn_marker = marker_position_arr[random_index] as Marker2D
	#instantiates the orb and connects the signal
	var damage_orb = DAMAGE_ORBS.instantiate() as Area2D
	damage_orb.position = spawn_marker.global_position
	#last_spawned_orb = orb.selected_orb.texture
	damage_orb.connect("apply_damage", get_gamage_orb_callBack_func.chec_if_orb_can_damage)
	add_child(damage_orb)
	

func _on_orb_spawn_t_imer_timeout():
	spawn_damage_orbs()
	

#background and camera func
func update_camera_position(delta):
	camera_2d.position.x += MIN_CAM_SPEED * delta

func _on_despawn_area_2d_area_entered(area):
	area.queue_free()

func update_ground_position():
	if camera_2d.position.x - ground.position.x > screen_size.x * 1.5:
		ground.position.x += screen_size.x

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
	if ScoreGlobals.total_current_score >= ScoreGlobals.LVL1_MAX_SCORE:
		#restart_button.position.x += 100
		GameControl.pause_game()
		hud.show_victory_label()
		restart_button.show()
		get_tree().paused = true
	
func game_over():
	if ScoreGlobals.total_current_score < ScoreGlobals.MIN_SCORE:
		restart_button.show()
		GameControl.game_over()
		get_tree().paused = true


func _on_area_2d_area_entered(area):
	area.queue_free()
