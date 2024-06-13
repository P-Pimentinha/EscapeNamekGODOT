extends State


@onready var player: PlayerMain = $"../.."
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"

func Enter():
	print("Falling")
	animated_sprite_2d.play("jump")
	

func Physics_Update(_delta : float):
	falling(_delta)
		
	
func Exit():
	pass

func falling(delta):
	player.velocity.y += player.GRAVITY * delta
	player.move_and_slide()
	
	if player.is_on_floor():
		state_transition.emit(self, "Running")
	
