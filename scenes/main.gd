extends Node

@onready var player = $Player
@onready var camera_2d = $Camera2D
@onready var ground = $Ground
@onready var hud = $hud
@onready var restart_button = $CanvasLayer
@onready var orb_spawn_timer = $Orb_Spawn_Timer
@onready var marker_position_arr: Array = [$Camera2D/Marker2D, $Camera2D/Marker2D2, $Camera2D/Marker2D3, $Camera2D/Marker2D4]
var orb_scene = preload ("res://scenes/objectives/OrbOfLight.tscn")

const PLAYER_START_POSITION := Vector2i(104, 528)
const CAM_START_POS := Vector2i(576, 324)

var screen_size: Vector2i
#var game_running: bool = false

func _ready():
	screen_size = get_window().size
	new_game()
	restart_button.get_node("Button").pressed.connect(restart)
	hud.unpause_game.connect(start_game_var)

func _physics_process(delta):
	#update ground position
	if GameControl.is_game_running:
		update_camera_position(delta)
		update_ground_position()
	player_wins()
	game_over()

#background and camera func
func update_camera_position(delta):
	camera_2d.position.x += 400 * delta

func _on_area_2d_area_entered(area):
	area.queue_free()

func update_ground_position():
	if camera_2d.position.x - ground.position.x > screen_size.x * 1.5:
		ground.position.x += screen_size.x

#orb logic
func spawn_orbs():
	var random_index = randi() % marker_position_arr.size()
	var random_value = marker_position_arr[random_index] as Marker2D
	var orb = orb_scene.instantiate() as Area2D
	orb.position = random_value.global_position
	add_child(orb)

func _on_orb_spawn_timer_timeout():
	spawn_orbs()
	
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
	
func game_over():
	if ScoreGlobals.total_current_score < ScoreGlobals.MIN_SCORE:
		restart_button.show()
		GameControl.game_over()
		get_tree().paused = true
	
func player_wins():
	if ScoreGlobals.total_current_score >= ScoreGlobals.MAX_SCORE:
		#restart_button.position.x += 100
		GameControl.pause_game()
		hud.show_victory_label()
		restart_button.show()
		get_tree().paused = true

func restart():
	get_tree().reload_current_scene()

#@onready var dino = $Dino
#@onready var camera_2d = $Camera2D
#@onready var ground = $Ground
#@onready var hud = $hud
#@onready var game_over_scene = $CanvasLayer
#
##preloads
#var stump_scene = preload("res://stump.tscn")
#var rock_scene = preload("res://rock.tscn")
#var barrel_scene = preload("res://barrel.tscn")
#var brid_scene = preload("res://bird.tscn")
#var obstacle_types := [stump_scene,rock_scene, barrel_scene]
#var obstacles: Array
#var bird_heights := [200,390]
#
##variables
#const DINO_START_POS := Vector2i(150,485)
#const CAM_START_POS := Vector2i(576, 324)
#var difficulty
#const MAX_DIFFICULTY : int = 2
#var score: int
#const SCORE_MODIFIER : int = 10
#const SPEED_MODIFIER : int = 5000
#var speed: float 
#const STAR_SPEED : float = 10.0
#const MAX_SPEED : float = 25.0
#var game_running: bool
#var screen_size : Vector2i
#var ground_height: int
#var last_obs
#
#
## Called when the node enters the scene tree for the first time.
#func _ready():
	#screen_size = get_window().size
	##ground_height = ground.get_node("Sprite2D").texture.get_height()
	#game_over_scene.get_node("Button").pressed.connect(new_game)
	#new_game()
#
#func _physics_process(delta):
	#
	#if game_running:
		#speed = STAR_SPEED + score / SPEED_MODIFIER
		#if speed > MAX_SPEED:
			#speed = MAX_SPEED
		#adjust_difficulty()
		#dino.position.x += speed
		#camera_2d.position.x += speed
		#update_ground_position()
		#for obs in obstacles:
			#if obs.position.x < (camera_2d.position.x - screen_size.x):
				#remove_obs(obs)
		#score += speed
		#show_score()
		##generate_obs()
	#else:
		#if Input.is_action_pressed("ui_accept"):
			#game_running = true
			#hud.get_node("StartLabel").hide()
#
#func new_game():
	#show_score()
	#game_running = false
	#get_tree().paused = false
	#difficulty = 0
	#
	#for obs in obstacles:
		#obs.queue_free()
	#obstacles.clear()
	#
	#dino.position = DINO_START_POS
	#dino.velocity = Vector2i(0,0)
	#camera_2d.position = CAM_START_POS
	#ground.position = Vector2i(0,0)
	#score = 0
	#game_over_scene.hide()
	#
	#
#
#func update_ground_position():
	#if camera_2d.position.x - ground.position.x > screen_size.x * 1.5:
		#ground.position.x += screen_size.x
#
#func show_score():
	#hud.get_node("ScoreLabel").text = "Score: " + str(score / SCORE_MODIFIER)
#
#func generate_obs():
	#if obstacles.is_empty() or last_obs.position.x < score + randi_range(300,500):
		#var obs_type = obstacle_types[randi() % obstacle_types.size()]
		#var obs
		#var max_obs = difficulty + 1
		#for i in range(randi()% max_obs + 1):
			#obs = obs_type.instantiate()
			#var obs_height = obs.get_node("Sprite2D").texture.get_height()
			#var obs_scale = obs.get_node("Sprite2D").scale
			#var obs_x : int = screen_size.x + score + 100 + (i*100)
			#var obs_y : int = screen_size.y - ground_height - (obs_height * obs_scale.y/2) + 5
			#last_obs = obs
			#add_obs(obs, obs_x, obs_y)
		#if difficulty == MAX_DIFFICULTY:
			#if(randi() % 2) == 0:
				#obs = brid_scene.instantiate()
				#var obs_x : int = screen_size.x + score + 100
				#var obs_y : int = bird_heights[randi() % bird_heights.size()]
				#add_obs(obs, obs_x, obs_y)
			#
		#
		#
	#
#func add_obs(obs,x,y):
	#obs.position = Vector2i(x, y)
	#obs.body_entered.connect(hit_obs)
	#add_child(obs)
	#obstacles.append(obs)
	#
#
#func remove_obs(obs):
	#obs.queue_free()
	#obstacles.erase(obs)
	#
#
#func hit_obs(body):
	#if body.name == "Dino":
		#game_over()
	#
#
#func adjust_difficulty():
	#difficulty = score / SPEED_MODIFIER
	#if difficulty > MAX_DIFFICULTY:
		#difficulty = MAX_DIFFICULTY
#
#func game_over():
	#get_tree().paused = true
	#game_running = false
	#game_over_scene.show()
