extends State


@onready var player: PlayerMain = $"../.."
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var run_colision_shape = $"../../Run"

func Enter():
	animated_sprite_2d.play("run")
	run_colision_shape.disabled = false
	run_colision_shape.visible = true
	

#func Update(_delta : float):
	#if(Input.is_action_just_pressed("use")):
		#print("Using")
		

func Physics_Update(_delta : float):
	trans_jump()
	trans_slide()
	player.move()
	
	
		
	
func Exit():
	run_colision_shape.disabled = true

func trans_jump():
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "Jumping")

func trans_slide():
	if Input.is_action_just_pressed("slide"):
		state_transition.emit(self, "Slide")

#func transition_to_walk():
	#if(Input.get_vector("Left", "Right", "Up", "Down").normalized()):
		#state_transition.emit(self, "Moving")
#
#func update_animation():
	#if player.last_direction_string == null:
		#player.last_direction_string = "Down"
		#animator.play("idle" + player.last_direction_string)
	#else:
		#animator.play("idle" + player.last_direction_string)
