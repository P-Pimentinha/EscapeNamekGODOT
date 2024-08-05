extends Node

var is_game_running: bool = false
var is_game_paused: bool = false
var is_player_on_menu: bool = false

func restart_game_state():
	is_game_paused = false
	is_game_running = false
	is_player_on_menu = true

func start_game():
	is_game_paused = false
	is_game_running = true
	is_player_on_menu = false

func unpause_game():
	is_game_paused = false
	is_game_running = true
	is_player_on_menu = false

func game_over():
	is_game_paused = true
	is_game_running = false
	is_player_on_menu = false

func pause_game():
	is_game_paused = false
	is_game_running = false
	is_player_on_menu = true
