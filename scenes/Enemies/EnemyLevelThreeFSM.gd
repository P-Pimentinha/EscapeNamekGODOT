extends State


@onready var enemy_one = $"../.."
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var hoverboard_sprite = $"../../hoverboard_sprite"
@onready var texture_progress_bar = $"../../TextureProgressBar"
@onready var progress_bar_timer = $"../../Progress_Bar_Timer"
@onready var take_damage_timer = $"../../Take_Damage_Timer"
@onready var dps_reboot_1_texture = $"../../dps_reboot_1"
@onready var dps_reboot_2_texture = $"../../dps_reboot_2"

var reboot_stage: int = 0
var current_damage_color: String = "black"

func Enter():
	#select_animation("reboot2",17,16)
	#select_animation("reboot3",17,16)
	select_animation("reboot",16,16)
	nodes_to_enable()
	progress_bar_timer.start()
	

func Update(_delta : float):
	pass
		

func Physics_Update(_delta : float):
	set_reboot_stage()
	
	
	
func Exit():
	pass


#health_bar
func _on_progress_bar_timer_timeout():
		texture_progress_bar.value += 5
		progress_bar_timer.start()


#take damage functions:
func take_damage():
	take_damage_timer.start()
	progress_bar_timer.stop()
	texture_progress_bar.value -= 5
	progress_bar_timer.start()
	
	if reboot_stage > 75:
		dps_reboot_1_texture.visible = true
	else:
		dps_reboot_1_texture.visible = true
	
func _on_take_damage_timer_timeout():
	dps_reboot_1_texture.visible = false
	dps_reboot_1_texture.visible = false

func chec_if_orb_can_damage(orb_color: String):
	print("Hello from Enemy")
	if orb_color == current_damage_color:
		take_damage()
	else:
		pass
	

func set_reboot_stage():
	if texture_progress_bar.value > 75:
		reboot_stage = 1
	elif texture_progress_bar.value > 35:
		reboot_stage = 2
	else:
		reboot_stage = 3
		

#enter functions
func select_animation(animation:String, position_x: int, position_y: int):
	
	hoverboard_sprite.play("reboot")
	
	animated_sprite_2d.stop()
	animated_sprite_2d.play(animation)
	animated_sprite_2d.position = Vector2(position_x,position_y)

func nodes_to_enable():
	texture_progress_bar.visible = true
