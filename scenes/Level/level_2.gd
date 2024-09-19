extends MainRootScene

#region OnReady
@onready var player = $Player
@onready var camera_2d = $Camera2D
@onready var hud = $Control/hud
@onready var restart_button = $Control/CanvasLayer
@onready var ground = $Ground
@onready var mortal_floor = $Mortal_Floor

@onready var aamer_egergy_strike: Timer = Timer.new()

#const PLAYER_START_POSITION := Vector2i(81, 428)
const PLAYER_START_POSITION := Vector2i(81, 428)
const CAM_START_POS := Vector2i(576, 324)
const MIN_CAM_SPEED: int = PlayerMain.MIN_SPEED

var screen_size: Vector2i


#region Process
func _ready():
	super()
	set_scene()
	
	

func _physics_process(delta):
	
	if GameControl.is_game_running:
		update_camera_position(delta)
		update_ground_position()
	game_over()
	pause_game(hud)

func set_scene():
	screen_size = get_window().size
	new_game(scene_new_game)
	restart_button.get_node("Button").pressed.connect(restart)
	hud.start_game_hud.connect(start_game)
	hud.unpause_game_hud.connect(unpause_game.bind(hud))	

#endregion


#region Camera Background
func update_camera_position(delta):
	camera_2d.position.x += MIN_CAM_SPEED * delta


func update_ground_position():
	if camera_2d.position.x - ground.position.x > screen_size.x * 1.5:
		ground.position.x += screen_size.x
		mortal_floor.position.x += screen_size.x
#endregion

func _on_despawn_area_area_entered(area):
	area.queue_free()

func _on_mortal_floor_body_entered(body: PlayerMain):
	##disabled to be able to test game
	#body.takes_mortal_damage()
	print("taking damage from floor")
	pass
	
#region Game State
func scene_new_game():
	restart_button.hide()
	player.position = PLAYER_START_POSITION
	player.velocity = Vector2i(0, 0)
	camera_2d.position = CAM_START_POS
	#test_g_round.position = Vector2i(0, 0)

func start_game():
	get_tree().paused = false
	hud.hide_hud()
	#orb_spawn_timer.start()
	GameControl.game_running()

func player_wins():
	#if ScoreGlobals.total_current_score >= ScoreGlobals.LVL1_MAX_SCORE:
		##restart_button.position.x += 100
		#GameControl.pause_game()
		#hud.show_victory_label()
		#restart_button.show()
		#get_tree().paused = true
	pass
	
func game_over():
	if player.player_took_damage or player.took_mortal_damage:
		restart_button.show()
		GameControl.game_over()
		get_tree().paused = true
#endregion



