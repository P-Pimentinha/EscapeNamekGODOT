extends MainRootScene

@onready var player = $Player
@onready var camera_2d = $Camera2D
@onready var hud = $Control/hud
@onready var restart_button = $Control/CanvasLayer
@onready var ground = $Ground

const PLAYER_START_POSITION := Vector2i(100, 528)
const CAM_START_POS := Vector2i(576, 324)
const MIN_CAM_SPEED: int = PlayerMain.MIN_SPEED

var screen_size: Vector2i

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	screen_size = get_window().size
	new_game(scene_new_game)
	restart_button.get_node("Button").pressed.connect(restart)
	hud.start_game_hud.connect(start_game)
	hud.unpause_game_hud.connect(unpause_game.bind(hud))
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if GameControl.is_game_running:
		update_camera_position(delta)
		update_ground_position()
	pause_game(hud)
	player_wins()
	game_over()


#background and camera func
func update_camera_position(delta):
	camera_2d.position.x += MIN_CAM_SPEED * delta


func update_ground_position():
	if camera_2d.position.x - ground.position.x > screen_size.x * 1.5:
		ground.position.x += screen_size.x

#game state
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
