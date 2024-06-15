extends CanvasLayer

@onready var score_label = $ScoreLabel
@onready var high_score_label = $HighScoreLabel
@onready var start_label = $StartLabel
@onready var win_label = $WinLabel
#@onready var initial_menu = $initial_menu
#@onready var key_bindings_menu = $key_bindings_menu
@onready var background_texture = $background_texture
@onready var main_menu = $main_menu
@onready var keybinding_menu = $keybinding_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	high_score_label.text = "Highest Score:   "
	keybinding_menu.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score_label.text = "Score:" + str(ScoreGlobals.total_current_score)
	menu_controls()

#change name
func hide_hud():
	main_menu.visible = false
	keybinding_menu.hide()
	background_texture.hide()

func show_victory_label():
	win_label.visible = true

func show_key_bindings():
	main_menu.hide()
	keybinding_menu.show()

func return_initial_menu():
	main_menu.show()
	keybinding_menu.hide()

func menu_controls():
	if GameControl.is_player_on_menu and Input.is_action_just_pressed("Menu_Show_Keys"):
		show_key_bindings()
	if GameControl.is_player_on_menu and Input.is_action_just_pressed("menu_return"):
		return_initial_menu()
