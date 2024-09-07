extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D

signal apply_damage

var selected_orb: String

var array_of_possible_orbs : Array = [
	"black", "orange", "green", "blue" 
]

func _ready():	
	instanciate_orb()

func instanciate_orb():
	#randomly selects the orb
	var random_index = randi() % array_of_possible_orbs.size()
	selected_orb = array_of_possible_orbs[random_index]
	#sets the texture
	animated_sprite_2d.play(selected_orb)
	
func _on_body_entered(body):
	apply_damage.emit(selected_orb)
	queue_free()
