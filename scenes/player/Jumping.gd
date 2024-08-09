extends State


@onready var player: PlayerMain = $"../.."
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var run = $"../../Run"

func Enter():
	animated_sprite_2d.play("jump")
	player.velocity.y = player.JUMP_SPEED
	run.disabled = false
	player.velocity.x = 800
	player.move_and_slide()
	

func Physics_Update(delta : float):
	print(player.velocity.x)
	jump(delta)
	player.aceletate_slow_down()
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
	if player.velocity.y > 0:
		state_transition.emit(self, "Falling")
