extends CharacterBody2D
class_name PlayerMain

@onready var fsm = $FSM as FiniteStateMachine
@onready var animated_sprite_2d = $AnimatedSprite2D
signal start_game
#jump
const GRAVITY : int = 4200
const JUMP_SPEED : int = -1800

#moving speed

const STOP_SPEED: float = 0
const START_SPEED : float = 400.0
const MAX_SPEED : float = 550
var speed: float = START_SPEED

func move():
	velocity.x = START_SPEED
	move_and_slide()

func stop():
	velocity.x = STOP_SPEED

func start_game_signal():
	start_game.emit()

#@onready var run_col = $RunCol
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
