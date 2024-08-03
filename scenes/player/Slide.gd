extends State

@onready var player: PlayerMain = $"../.."
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var slide_timer = $"../../Timers/SlideTimer"
@onready var slide = $"../../Slide"

func Enter():
	animated_sprite_2d.play("slide")
	slide_timer.start()
	slide.disabled = false
	

func Physics_Update(delta : float):
	player.move()
	player.velocity.y += player.GRAVITY * delta
		
	
func Exit():
	animated_sprite_2d.stop()

	


func _on_slide_timer_timeout():
	slide.disabled = true
	state_transition.emit(self, "Running")
