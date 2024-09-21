extends MainRootScene


@export var score_resource: LevelOneScoreResource

#region On Ready
@onready var music_1: AudioStreamPlayer = $Audios/music1
@onready var music_2: AudioStreamPlayer = $Audios/music2
@onready var music_3 = $Audios/music3
@onready var player = $Player
@onready var camera_2d = $Camera2D
@onready var ground = $Ground
@onready var hud = $Control/hud
@onready var restart_button = $Control/CanvasLayer
@onready var orb_spawn_timer = $Timers/Orb_Spawn_TImer
@onready var marker_position_arr: Array = [$Camera2D/OrbSpawnMarker, $Camera2D/OrbSpawnMarker2, $Camera2D/OrbSpawnMarker3, $Camera2D/OrbSpawnMarker4]
@onready var floor_burning_position = $Camera2D/FloorBurningPosition
#endregion

var orb_scene = preload ("res://scenes/objectives/OrbOfLight.tscn")
var last_spawned_orb

const PLAYER_START_POSITION := Vector2i(100, 528)
const CAM_START_POS := Vector2i(576, 324)
const MIN_CAM_SPEED: int = PlayerMain.MIN_SPEED

var screen_size: Vector2i
 
#region Processd
func _ready():
	super()
	set_scene()

func _physics_process(delta):
	#update ground position
	if GameControl.is_game_running:
		update_camera_position(delta)
		update_ground_position()
	pause_game(hud)
	player_wins()
	game_over()
	change_background_music()
	
func set_scene():
	#screen size used to update floor
	screen_size = get_window().size
	#sets the initial state of the scene
	new_game(scene_new_game)
	#sets the score to Null
	score_resource.reset_total_current_score()
	#connets with HUD signals
	restart_button.get_node("Button").pressed.connect(restart)
	hud.start_game_hud.connect(start_game)
	hud.unpause_game_hud.connect(unpause_game.bind(hud))	
#endregion

#orb logic
#region Orb Logic
func spawn_orbs():
	var random_index = randi() % marker_position_arr.size()
	var random_value = marker_position_arr[random_index] as Marker2D
	var orb = orb_scene.instantiate() as Area2D
	orb.position = random_value.global_position
	#last_spawned_orb = orb.selected_orb.texture
	add_child(orb)
	#pass
	

func _on_orb_spawn_t_imer_timeout():
	spawn_orbs()
#endregion

#sound effects
#region Sound
func change_background_music():
	if score_resource.total_current_score > 20 and  music_1.playing:
		music_1.stop()
		music_2.play()
	if score_resource.total_current_score > 40 and  music_2.playing:	
		music_2.stop()
		music_3.play()
#endregion

#background and camera func
#region Background Camera
func update_camera_position(delta):
	camera_2d.position.x += MIN_CAM_SPEED * delta

func _on_despawn_area_2d_area_entered(area):
	area.queue_free()

func update_ground_position():
	if camera_2d.position.x - ground.position.x > screen_size.x * 1.5:
		ground.position.x += screen_size.x
#endregion

#game state
#region Game State
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
	if score_resource.total_current_score >= score_resource.lvl1_max_score:
		#restart_button.position.x += 100
		#GameControl.pause_game()
		#hud.show_victory_label()
		#restart_button.show()
		#get_tree().paused = true
		get_tree().change_scene_to_file("res://scenes/CutScene/cut_scene_one.tscn")
	
func game_over():
	if score_resource.total_current_score < score_resource.min_score or player.took_mortal_damage:
		restart_button.show()
		GameControl.game_over()
		get_tree().paused = true
	
#endregion



#!!!!!!!!!!!!!!!!!!!!!!!!!
#func _on_player_speed_killswitch_body_entered(body):
	#body.killSitch_sub(true)
#
#
#func _on_player_speed_killswitch_body_exited(body):
	#body.killSitch_sub(false)

#Alternative to Static Body 2D --- Currently not in use
func _on_area_2d_body_entered(body):
	body.kill_switch_on_off(true)


func _on_area_2d_body_exited(body):
	body.kill_switch_on_off(false)
