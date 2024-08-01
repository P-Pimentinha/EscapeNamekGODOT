extends MainRootScene

@export var level_resources: CustomLevelOneResource

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

var orb_scene = preload ("res://scenes/objectives/OrbOfLight.tscn")
var last_spawned_orb

const PLAYER_START_POSITION := Vector2i(104, 528)
const CAM_START_POS := Vector2i(576, 324)

var screen_size: Vector2i
 
func _ready():
	Engine.max_fps = 60
	super()
	screen_size = get_window().size
	new_game()
	restart_button.get_node("Button").pressed.connect(restart)
	hud.unpause_game.connect(start_game_var)

func _physics_process(delta):
	#update ground position
	if GameControl.is_game_running:
		update_camera_position(delta)
		update_ground_position()
	pause_game()
	player_wins()
	game_over()
	change_background_music()

#orb logic
func spawn_orbs():
	var random_index = randi() % marker_position_arr.size()
	var random_value = marker_position_arr[random_index] as Marker2D
	var orb = orb_scene.instantiate() as Area2D
	orb.position = random_value.global_position
	#last_spawned_orb = orb.selected_orb.texture
	add_child(orb)
	
	

func _on_orb_spawn_t_imer_timeout():
	spawn_orbs()

#sound effects
func change_background_music():
	if ScoreGlobals.total_current_score > 20 and  music_1.playing:
		music_1.stop()
		music_2.play()
	if ScoreGlobals.total_current_score > 40 and  music_2.playing:	
		music_2.stop()
		music_3.play()

#background and camera func
func update_camera_position(delta):
	camera_2d.position.x += 400 * delta

func _on_despawn_area_2d_area_entered(area):
	area.queue_free()

func update_ground_position():
	if camera_2d.position.x - ground.position.x > screen_size.x * 1.5:
		ground.position.x += screen_size.x

#game state
func new_game():
	get_tree().paused = true
	GameControl.restart_game_state()
	ScoreGlobals.reset_total_current_score()
	restart_button.hide()
	player.position = PLAYER_START_POSITION
	player.velocity = Vector2i(0, 0)
	camera_2d.position = CAM_START_POS
	ground.position = Vector2i(0, 0)

func start_game_var():
	get_tree().paused = false
	hud.hide_hud()
	orb_spawn_timer.start()
	GameControl.start_game()

func pause_game():
	if Input.is_action_pressed("pause"):
		GameControl.pause_game()
		hud.show_hud()
		get_tree().paused = true

func unpause_game():
	get_tree().paused = false
	GameControl.unpause_game()
	
func player_wins():
	if ScoreGlobals.total_current_score >= ScoreGlobals.MAX_SCORE:
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
	
func restart():
	get_tree().reload_current_scene()
