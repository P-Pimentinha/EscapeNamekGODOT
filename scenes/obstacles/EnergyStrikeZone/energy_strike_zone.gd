extends Area2D


@onready var danger_area = $DangerArea
@onready var energy_strike = $EnergyStrike
@onready var collision_shape_2d = $CollisionShape2D
@export var score_to_be_taken: int = -5
@export var score_resources: LevelOneScoreResource

signal animation_finished_strike_zone

# Called when the node enters the scene tree for the first time.
func _ready():
	danger_area.stop()
	danger_area.play("animation1")
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_danger_area_animation_finished():
	danger_area.visible=false
	energy_strike.visible = true
	collision_shape_2d.disabled = false
	energy_strike.play("new_animation")


func _on_energy_strike_animation_finished():
	animation_finished_strike_zone.emit()
	queue_free()


func _on_body_entered(body):
	if body is PlayerMain:
		body.take_damage(-5)
		queue_free()
