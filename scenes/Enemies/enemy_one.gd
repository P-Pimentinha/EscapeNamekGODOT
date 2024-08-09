extends CharacterBody2D

const PROJECTILE_SCENE = preload ("res://scenes/Enemies/projectiles/projectile.tscn")
const BURNING_FLOOR = preload("res://scenes/obstacles/burning_floor/burning_floor.tscn")
@onready var marker_2d = $Marker2D
@onready var fire_timer = $FireTimer
@onready var projectile_timer = $ProjectileTimer
@onready var animated_sprite_2d = $AnimatedSprite2D




# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite_2d.play("default")
	#fire_timer.start()
	projectile_timer.start()
	
	

func spawn_projectiles():
	animated_sprite_2d.play("attack_1")
	var projectile = PROJECTILE_SCENE.instantiate() as Area2D
	projectile.position = marker_2d.position
	#projectile.connect("animation_finished", end_attack_animation)
	projectile.animation_finished.connect(end_attack_animation)
	add_child(projectile)
	

func spawn_fire():
	var node_to_add_child = get_node("%Obstacles")
	var ground_fire_position = get_parent().get_node("FloorBurningPosition")
	var ground_fire = BURNING_FLOOR.instantiate() as Area2D
	ground_fire.position = ground_fire_position.global_position
	node_to_add_child.add_child(ground_fire)
	
	
func _on_fire_timer_timeout():
	spawn_fire()
	
func _on_projectile_timer_timeout():
	spawn_projectiles()


func end_attack_animation():
	animated_sprite_2d.stop()
	animated_sprite_2d.play("default")
