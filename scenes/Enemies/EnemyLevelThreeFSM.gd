extends State


#region Ready
const ENERGY_STRIKE_ZONE = preload("res://scenes/obstacles/EnergyStrikeZone/energy_strike_zone.tscn")
@onready var enemy_one = $"../.."
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var hoverboard_sprite = $"../../hoverboard_sprite"
@onready var texture_progress_bar = $"../../TextureProgressBar"
@onready var progress_bar_timer = $"../../Progress_Bar_Timer"
@onready var damage_texture_timer = $"../../Take_Damage_Timer"
@onready var dps_reboot_1_texture = $"../../dps_reboot_1"
@onready var dps_reboot_2_texture = $"../../dps_reboot_2"
@onready var change_color_for_damage = $"../../ChangeColorForDamage"
@onready var energy_strike_timer = $"../../EnergyStrikeTimer"
signal life_reached_zero

#endregion

#region Var
var reboot_stage: int
var current_color: String = "black"
var damage_colors: Array = [
	"black", "orange", "green", "blue"
]

const ENERGY_STRIKE_Y_POSITION = 560
#endregion

#region Process
func Enter():
	set_scene()
	set_reboot_stage()
	select_animation("reboot", 16, 16)
	

func Update(_delta: float):
	pass
		

func Physics_Update(_delta: float):
	set_reboot_stage()
	
	
func Exit():
	pass
#endregion


#health_bar
func _on_progress_bar_timer_timeout():
		texture_progress_bar.value += 7
		progress_bar_timer.start()
		#set_animation()

#region Damage Functions
func check_if_orb_can_damage(orb_color: String):
	if orb_color == current_color:
		take_damage()
		#set_reboot_stage()
		set_animation()
	else:
		pass


func take_damage():
	set_damage_texture()
	#timer that will disable the damage texture starts
	damage_texture_timer.start()
	#health bar timer progression is interrupted
	progress_bar_timer.stop()
	#damage is applied
	texture_progress_bar.value -= 50
	if texture_progress_bar.value <= 0:
		life_reached_zero.emit()
	#starts health bar timer
	progress_bar_timer.start()
	

func set_reboot_stage():
	if texture_progress_bar.value > 75:
		reboot_stage = 1
	elif texture_progress_bar.value > 35:
		reboot_stage = 2
	else:
		reboot_stage = 3

func set_animation():
	animated_sprite_2d.play("reboot" + str(reboot_stage) + "_" + current_color)
	
func set_damage_texture():

	if texture_progress_bar.value > 75:
		dps_reboot_1_texture.visible = true
	else:
		dps_reboot_2_texture.visible = true

func _on_change_color_for_damage_timeout():
	var new_color = current_color
	while new_color == current_color:
		var random_index = randi() % damage_colors.size()
		new_color = damage_colors[random_index]
	current_color = new_color
	change_color_for_damage.start()
	set_animation()
	
	
func _on_take_damage_timer_timeout():
	#disables all dps textures
	dps_reboot_1_texture.visible = false
	dps_reboot_2_texture.visible = false
#endregion

#region Apply Damage To Player
func spawn_energy_strike():
	#var parent_node = enemy_one.get_node("%FloorBurningPosition")
	#var position_node = enemy_one.get_node("%Player")
	#var energy_strike_zone = ENERGY_STRIKE_ZONE.instantiate() as Area2D
	#
	#var random_x_offset = randi_range(-120, 120)
	#parent_node.add_child(energy_strike_zone)
	##energy_strike_zone.global_position.x = position_node.global_position.x + Vector2(random_x_offset,0)
	#energy_strike_zone.global_position.x = position_node.global_position.x
	#energy_strike_zone.global_position.y = ENERGY_STRIKE_Y_POSITION
	#energy_strike_timer.start()
	pass

func _on_energy_strike_timer_timeout():
	spawn_energy_strike()
	
#endregion

#region Enter Functions
func select_animation(animation: String, position_x: int, position_y: int):
	hoverboard_sprite.play(animation)
	animated_sprite_2d.stop()
	set_animation()
	animated_sprite_2d.position = Vector2(position_x, position_y)

func set_scene():
	texture_progress_bar.visible = true
	energy_strike_timer.start()
	texture_progress_bar.value = 2
	progress_bar_timer.start()
	texture_progress_bar.visible = true
#endregion
