extends CanvasLayer

#@onready var score_label = $ScoreLabel
#@onready var start_label = $StartLabel
@onready var win_label = $WinLabel
@onready var background_texture = $background_texture
@onready var main_menu = $main_menu
@onready var keybinding_menu = $keybinding_menu

signal unpause_game_hud
signal start_game_hud

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	menu_controls()

#labels
func show_victory_label():
	win_label.visible = true
	
#menu
func hide_hud():
	main_menu.visible = false
	keybinding_menu.hide()
	background_texture.hide()

func show_hud():
	main_menu.visible = true
	#keybinding_menu.show()
	background_texture.show()

func show_key_bindings():
	main_menu.hide()
	keybinding_menu.show()

func return_initial_menu():
	main_menu.show()
	keybinding_menu.hide()

func menu_controls():
	if Input.is_action_just_pressed("right") and GameControl.is_new_game:
		start_game_hud.emit()
	if Input.is_action_just_pressed("right") and !GameControl.is_new_game:
		unpause_game_hud.emit()
	if GameControl.is_player_on_menu and Input.is_action_just_pressed("Menu_Show_Keys"):
		show_key_bindings()
	if GameControl.is_player_on_menu and Input.is_action_just_pressed("menu_return"):
		return_initial_menu()
