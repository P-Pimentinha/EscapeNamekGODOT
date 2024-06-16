extends CanvasLayer

@onready var score_label = $ScoreLabel
@onready var high_score_label = $HighScoreLabel
@onready var start_label = $StartLabel
@onready var win_label = $WinLabel
@onready var progress_bar = $TextureProgressBar
@onready var background_texture = $background_texture
@onready var main_menu = $main_menu
@onready var keybinding_menu = $keybinding_menu

signal unpause_game

# Called when the node enters the scene tree for the first time.
func _ready():
	high_score_label.text = "Highest Score:   "
	keybinding_menu.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_score_label()
	update_progress_bar()
	menu_controls()

#labels
func show_victory_label():
	win_label.visible = true

func update_score_label():
	score_label.text = "Score:" + str(ScoreGlobals.total_current_score)
	
#menu
func hide_hud():
	main_menu.visible = false
	keybinding_menu.hide()
	background_texture.hide()

func show_key_bindings():
	main_menu.hide()
	keybinding_menu.show()

func return_initial_menu():
	main_menu.show()
	keybinding_menu.hide()

func menu_controls():
	if Input.is_action_just_pressed("right"):
		get_tree().paused = false
		unpause_game.emit()
	if GameControl.is_player_on_menu and Input.is_action_just_pressed("Menu_Show_Keys"):
		show_key_bindings()
	if GameControl.is_player_on_menu and Input.is_action_just_pressed("menu_return"):
		return_initial_menu()

# progress bar 
func update_progress_bar():
	progress_bar.value = ScoreGlobals.total_current_score
