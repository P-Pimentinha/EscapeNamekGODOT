extends State


@onready var player: PlayerMain = $"../.."
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"


func Enter():
	print("Idle")
	animated_sprite_2d.play("idle")
	

#func Update(_delta : float):
	#if(Input.is_action_just_pressed("use")):
		#print("Using")
		

func Physics_Update(_delta : float):
	if Input.is_action_just_pressed("right") or GameControl.is_game_running:
		state_transition.emit(self, "Running")
	
	
	
		
	
func Exit():
	pass

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
