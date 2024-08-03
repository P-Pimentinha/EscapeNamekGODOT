extends State


@onready var player: PlayerMain = $"../.."
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var run = $"../../Run"

func Enter():
	animated_sprite_2d.play("jump")
	player.velocity.y = player.JUMP_SPEED
	run.disabled = false
	

func Physics_Update(_delta : float):
	jump(_delta)
	if Input.is_action_just_released("jump"):
		player.velocity.y = -330
		state_transition.emit(self, "Falling")
	
func Exit():
	pass


func jump(delta):
	
	player.velocity.y += player.GRAVITY * delta
	player.move_and_slide()
	#
	#if player.is_on_floor():
		#state_transition.emit(self, "Running")
	print(player.velocity.y)
	if player.velocity.y > 0:
		state_transition.emit(self, "Falling")
