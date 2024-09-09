extends CanvasLayer

@export var Score_Resource: LevelOneScoreResource
@onready var texture_progress_bar = $TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	texture_progress_bar.max_value = Score_Resource.lvl1_max_score


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_progress_bar()

func update_progress_bar():
	texture_progress_bar.value = Score_Resource.total_current_score
