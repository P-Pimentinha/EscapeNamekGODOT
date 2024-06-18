extends CanvasLayer

@onready var texture_progress_bar = $TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_progress_bar()

func update_progress_bar():
	texture_progress_bar.value = ScoreGlobals.total_current_score
