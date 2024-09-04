extends Area2D


var original_position
@onready var animated_sprite_2d = $Sprite2D
var selected_orb
signal apply_damage

var array_of_possible_orbs : Array = [
	{"texture": "black", "color": "black"},
]




func _ready():	

	#var random_index = randi() % array_of_possible_orbs.size()
	#selected_orb = array_of_possible_orbs[random_index]
	#animated_sprite_2d.play(selected_orb["texture"])
	#original_position = position
	pass

func _physics_process(delta):
	pass



func _on_body_entered(body):
	apply_damage.emit("black")
