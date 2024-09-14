extends CharacterBody2D
class_name PlayerMain

@export var score_resource: LevelOneScoreResource
@onready var fsm = $FSM as FiniteStateMachine
#@onready var animated_sprite_2d = $AnimatedSprite2D
#@onready var run_colision_shape = $Run
#@onready var idle_colision_shape = $Idle


#jump
const GRAVITY: int = 4200
const JUMP_SPEED: int = -1800

#moving speed
const STOP_SPEED: float = 0
const MIN_SPEED: float = 400.0
const MAX_SPEED: float = 550
var current_speed: float = MIN_SPEED
var added_speed: int = 0
var accelerate_kill_switch: bool = false
var player_took_damage: bool = false
var took_mortal_damage: bool = false

#region movement functions
func move():
	velocity.x = current_speed + (added_speed)
	move_and_slide()
		
func stop():
	velocity.x = STOP_SPEED

func aceletate_slow_down():
	if Input.is_action_pressed("right") and !accelerate_kill_switch:
		added_speed = 100
	if Input.is_action_just_released("right"):
		added_speed = 0
	
	elif Input.is_action_pressed("left"):
		added_speed = -100
	elif Input.is_action_just_released("left"):
		added_speed = 0
	
#endregion
func takes_mortal_damage():
	took_mortal_damage = true

func take_damage(damage: int):
	score_resource.add_current_score(damage)
	# variable to be used in level two and tree
	player_took_damage = true
	
func kill_switch_on_off(value: bool):
	accelerate_kill_switch = value
	if value:
		added_speed = 0


#@onready var duck_col = $DuckCol

## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
#
#func _physics_process(delta):
	#
	#velocity.y += GRAVITY * delta
	#
	#if Input.is_action_pressed("ui_accept"):
		#velocity.y = JUMP_SPEED
	#
	##if is_on_floor():
		##if not get_parent().game_running:
			##animated_sprite_2d.play("idle")
		##else:
			##run_col.disabled = false
			##duck_col.disabled = true
			##if Input.is_action_pressed("ui_accept"):
				##velocity.y = JUMP_SPEED
			##elif Input.is_action_pressed("ui_down"):
				##animated_sprite_2d.play("duck")
				##duck_col.disabled = false
				##run_col.disabled = true
			##else:
				##animated_sprite_2d.play("run")
	##else:
		##animated_sprite_2d.play("jump")
		#
	#move_and_slide()
