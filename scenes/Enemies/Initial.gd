extends State

@onready var enemy_one = $"../.."
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"

func Enter():
	animated_sprite_2d.play("reboot")
	pass

func Update(_delta : float):
	pass
		

func Physics_Update(_delta : float):
	
	state_transition.emit(self, enemy_one.level_to_load)
	
	
	
func Exit():
	pass
