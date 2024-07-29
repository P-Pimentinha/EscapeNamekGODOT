extends CharacterBody2D

var projectile_scene = preload ("res://scenes/Enemies/projectiles/projectile.tscn")
@onready var marker_2d = $Marker2D
@onready var marker_2d_2 = $NMarker2D2
@onready var marker_2d_3 = $Marker2D3
const BURNING_FLOOR = preload("res://scenes/obstacles/burning_floor/burning_floor.tscn")
@onready var fire_timer = $FireTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_bullets()
	fire_timer.start()
	
	

func spawn_bullets():
	var projectile = projectile_scene.instantiate() as Area2D
	projectile.position = marker_2d.position
	add_child(projectile)
	

func spawn_fire():
	var node_to_add_child = get_node("%Obstacles")
	var ground_fire_position = get_parent().get_node("FloorBurningPosition")
	var ground_fire = BURNING_FLOOR.instantiate() as Area2D
	ground_fire.position = ground_fire_position.global_position
	node_to_add_child.add_child(ground_fire)
	
	


func _on_fire_timer_timeout():
	spawn_fire()
