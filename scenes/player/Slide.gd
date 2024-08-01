extends State

@onready var player: PlayerMain = $"../.."
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"

func Enter():
	animated_sprite_2d.play("slide")
	

func Physics_Update(_delta : float):
	slidding(_delta)
		
	
func Exit():
	pass

func slidding(delta):
	player.velocity.y += player.GRAVITY * delta
	player.move_and_slide()

	
