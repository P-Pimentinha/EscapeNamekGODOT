extends Node

var is_game_running: bool = false
var is_game_paused: bool = false
var is_player_on_menu: bool = false
var is_new_game: bool = false

func new_game():
	is_game_paused = true
	is_game_running = false
	is_player_on_menu = true
	is_new_game = true


func game_running():
	is_game_paused = false
	is_game_running = true
	is_player_on_menu = false
	is_new_game = false

func game_over():
	is_game_paused = true
	is_game_running = false
	is_player_on_menu = false
	is_new_game = false


func pause_game():
	is_game_paused = true
	is_game_running = false
	is_player_on_menu = true
	is_new_game = false

func unpause_game():
	is_game_paused = false
	is_game_running = true
	is_player_on_menu = false
	is_new_game = false

func on_cutscene():
	is_game_paused = false
	is_game_running = false
	is_player_on_menu = false
	is_new_game = false
	
