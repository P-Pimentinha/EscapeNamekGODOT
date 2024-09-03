extends State


@onready var enemy_one = $"../.."
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var hoverboard_sprite = $"../../hoverboard_sprite"

func Enter():
	#select_animation("reboot2",17,16)
	#select_animation("reboot3",17,16)
	select_animation("reboot",16,16)
	hoverboard_sprite.play("reboot")

func Update(_delta : float):
	pass
		

func Physics_Update(_delta : float):
	pass
	
	
	
func Exit():
	pass



func select_animation(animation:String, position_x: int, position_y: int):
	animated_sprite_2d.stop()
	animated_sprite_2d.play(animation)
	animated_sprite_2d.position = Vector2(position_x,position_y)
