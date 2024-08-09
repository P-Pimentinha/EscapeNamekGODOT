extends State


@onready var player: PlayerMain = $"../.."
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var run = $"../../Run"

func Enter():
	run.disabled = false
	animated_sprite_2d.play("jump")
	

func Physics_Update(delta : float):
	falling(delta)
	player.aceletate_slow_down()
	
func Exit():
	pass

func falling(delta):
	player.velocity.y += player.GRAVITY * delta
	player.move_and_slide()
	
	if player.is_on_floor():
		state_transition.emit(self, "Running")
	
