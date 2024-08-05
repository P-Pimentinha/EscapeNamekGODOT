extends State

@onready var player: PlayerMain = $"../.."
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var slide_timer = $"../../Timers/SlideTimer"
@onready var slide_colision = $"../../Slide"

func Enter():
	animated_sprite_2d.play("slide")
	slide_timer.start()
	slide_colision.disabled = false
	

func Physics_Update(delta : float):
	player.move()
	player.velocity.y += player.GRAVITY * delta
	trans_to_another_state()
		
	
func Exit():
	slide_timer.stop()
	animated_sprite_2d.stop()
	slide_colision.disabled = true

	

func trans_to_another_state():
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "Jumping")
	if Input.is_action_just_pressed("right"):
		state_transition.emit(self, "Running")

func _on_slide_timer_timeout():
	state_transition.emit(self, "Running")
