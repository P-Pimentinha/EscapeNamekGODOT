extends State


#region Ready
const ENERGY_STRIKE_ZONE = preload("res://scenes/obstacles/EnergyStrikeZone/energy_strike_zone.tscn")
@onready var enemy_one = $"../.."
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var hoverboard_sprite = $"../../hoverboard_sprite"
@onready var texture_progress_bar = $"../../TextureProgressBar"
@onready var progress_bar_timer = $"../../Progress_Bar_Timer"
@onready var take_damage_timer = $"../../Take_Damage_Timer"
@onready var dps_reboot_1_texture = $"../../dps_reboot_1"
@onready var dps_reboot_2_texture = $"../../dps_reboot_2"
@onready var change_color_for_damage = $"../../ChangeColorForDamage"
@onready var energy_strike_timer = $"../../EnergyStrikeTimer"


#endregion

#region Var
var reboot_stage: int
var current_color: String = "black"
var damage_colors : Array = [
	"black", "orange", "green", "blue" 
]

const ENERGY_STRIKE_Y_POSITION = 560
#endregion

#region Process
func Enter():
	
	#select_animation("reboot2",17,16)
	#select_animation("reboot3",17,16)
	texture_progress_bar.value = 0
	set_reboot_stage()
	select_animation("reboot",16,16)
	nodes_to_enable()
	progress_bar_timer.start()
	texture_progress_bar.visible = true

func Update(_delta : float):
	pass
		

func Physics_Update(_delta : float):
	set_reboot_stage()
	
	
	
func Exit():
	pass
#endregion


#health_bar
func _on_progress_bar_timer_timeout():
		texture_progress_bar.value += 5
		progress_bar_timer.start()
		set_animation()


#region Damage Functions
func chec_if_orb_can_damage(orb_color: String):
	if orb_color == current_color:
		take_damage()
		set_reboot_stage()
		set_animation()
	else:
		pass


func take_damage():
	set_damage_texture()
	#timer that will disable the damage texture starts
	take_damage_timer.start()
	#the timer of the health bar is interrupted
	progress_bar_timer.stop()
	#enemy takes damage
	texture_progress_bar.value -= 5
	#tstarts the health bar timer
	progress_bar_timer.start()
	

func set_reboot_stage():
	if texture_progress_bar.value > 75:
		reboot_stage = 1
	elif texture_progress_bar.value > 35:
		reboot_stage = 2
	else:
		reboot_stage = 3

func set_animation():
	#if texture_progress_bar.value > 75:
		#animated_sprite_2d.play("reboot" + str(reboot_stage) + "_" + current_color)
	#elif texture_progress_bar.value > 35:
		#animated_sprite_2d.play("reboot2")
	#else:
		#animated_sprite_2d.play("reboot3")
	animated_sprite_2d.play("reboot" + str(reboot_stage) + "_" + current_color)
	
func set_damage_texture():
	if texture_progress_bar.value > 75:
		dps_reboot_1_texture.visible = true
	else:
		dps_reboot_2_texture.visible = true

func _on_change_color_for_damage_timeout():
	var random_index = randi() % damage_colors.size()
	current_color = damage_colors[random_index]
	change_color_for_damage.start()
	
	
func _on_take_damage_timer_timeout():
	#disables all dps textures
	dps_reboot_1_texture.visible = false
	dps_reboot_2_texture.visible = false
#endregion

#region Apply Damage To Player
func spawn_energy_strike():
	var parent_node = enemy_one.get_node("%FloorBurningPosition")
	var position_node = enemy_one.get_node("%Player")
	var energy_strike_zone = ENERGY_STRIKE_ZONE.instantiate() as Area2D
	
	var random_x_offset = randi_range(-120,120)
	parent_node.add_child(energy_strike_zone)
	#energy_strike_zone.global_position.x = position_node.global_position.x + Vector2(random_x_offset,0)
	energy_strike_zone.global_position.x = position_node.global_position.x
	energy_strike_zone.global_position.y = ENERGY_STRIKE_Y_POSITION
	energy_strike_timer.start()

func _on_energy_strike_timer_timeout():
	spawn_energy_strike()
	
#endregion

#region Enter Functions
func select_animation(animation:String, position_x: int, position_y: int):
	
	hoverboard_sprite.play("reboot")
	
	animated_sprite_2d.stop()
	set_animation()
	animated_sprite_2d.position = Vector2(position_x,position_y)

func nodes_to_enable():
	texture_progress_bar.visible = true
	energy_strike_timer.start()
#endregion



