extends CharacterBody2D

var projectile_scene = preload ("res://scenes/Enemies/projectiles/projectile.tscn")
@onready var marker_2d = $Node2D/Marker2D

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_bullets()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func spawn_bullets():
	var projectile = projectile_scene.instantiate() as Area2D
	projectile.position = marker_2d.position
	add_child(projectile)
	
