extends CanvasLayer

#@onready var score_label = $ScoreLabel
#@onready var start_label = $StartLabel
@onready var win_label = $WinLabel
@onready var background_texture = $background_texture
@onready var main_menu = $main_menu
@onready var options_menu = $OptionsMenu
@onready var tip_menu_main = $TipMenuMain
@onready var tips_menu_lv_l_1 = $TipsMenuLvL1
@onready var tips_menu_lv_l_2 = $TipsMenuLvL2
@onready var tips_menu_lv_l_3 = $TipsMenuLvL3
@onready var return_init_menu_label = $return_init_menu_label
@onready var array_of_sub_menus: Array = [main_menu,options_menu, tip_menu_main, tips_menu_lv_l_1, tips_menu_lv_l_2, tips_menu_lv_l_3]
@onready var level_1 = $main_menu/Level1
@onready var level_2 = $main_menu/Level2
@onready var level_3 = $main_menu/Level3


signal unpause_game_hud
signal start_game_hud

# Called when the node enters the scene tree for the first time.
func _ready():
	select_label_level()
	show()
	main_menu.show()
	return_init_menu_label.hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	menu_controls()

#labels
func show_victory_label():
	win_label.visible = true

func select_label_level():
	level_1.visible = false
	level_2.visible = false
	level_3.visible = false
	
	if GameLevelController.current_level == 1:
		level_1.visible = true
	elif GameLevelController.current_level == 2:
		level_2.visible = true
	elif GameLevelController.current_level == 3:
		level_3.visible = true

#menu
func hide_hud():
	visible = false
	#main_menu.visible = false
	#optnions_menu.hide()
	#background_texture.hide()

func show_hud():
	visible = true
	#main_menu.visible = true
	##optnions_menu.show()
	#background_texture.show()

func show_options_menu():
	main_menu.hide()
	options_menu.show()
	return_init_menu_label.show()

func return_initial_menu():
	for element in array_of_sub_menus:
		element.hide()
	main_menu.show()
	return_init_menu_label.hide()


func menu_controls():
	if Input.is_action_just_pressed("right") and GameControl.is_new_game:
		start_game_hud.emit()
		return_initial_menu()
	if Input.is_action_just_pressed("right") and !GameControl.is_new_game:
		unpause_game_hud.emit()
		return_initial_menu()
	if Input.is_action_just_pressed("menu_return"):
		return_initial_menu()
		
	#if GameControl.is_player_on_menu and Input.is_action_just_pressed("menu_return"):
		#print("return")
		#return_initial_menu()

func _on_options_button_pressed():
	show_options_menu()

func _on_tips_button_pressed():
	main_menu.hide()
	tip_menu_main.show()
	return_init_menu_label.show()
