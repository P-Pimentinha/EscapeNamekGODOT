extends CanvasLayer

@onready var score_label = $ScoreLabel
@onready var high_score_label = $HighScoreLabel
@onready var start_label = $StartLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	high_score_label.text = "Highest Score:   "


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score_label.text = "Score:" + str(ScoreGlobals.total_current_score)
	
func hide_start_label():
	start_label.visible = false
