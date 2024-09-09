extends Node2D
class_name MainRootScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(Engine.get_frames_per_second())
	pass

func new_game(scene_new_game: Callable):
	get_tree().paused = true
	GameControl.new_game()
#move to different function?
	scene_new_game.call()

func pause_game(hud: CanvasLayer):
	if Input.is_action_pressed("pause"):
		GameControl.pause_game()
		hud.show_hud()
		get_tree().paused = true

func unpause_game(hud):
	
	get_tree().paused = false
	hud.hide_hud()
	GameControl.unpause_game()

func restart():
	get_tree().reload_current_scene()
