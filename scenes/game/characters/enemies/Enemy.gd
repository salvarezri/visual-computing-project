class_name Enemy
extends CharacterBody2D

@export var ACCELERATION = 60
@export var MAX_SPEED = 60
@export var FRICTION = 60

@export var target: Player
@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var healtComponent: HealtComponent = $HealtComponent
@export var dmg_per_hit:int = 2

var direction: Vector2 = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	if target:
		nav.target_position = target.position
	else: 
		nav.target_position = Vector2(500,500)
	pass # Replace with function body.

func _process(delta):
	#rotation
	look_at(nav.get_next_path_position())
	rotation = rotation-PI/2
	if target:
		nav.target_position = target.position
	else: 
		nav.target_position = Vector2(500,500)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Get the direction marked by the navigation agent
	var direction :Vector2 = (nav.get_next_path_position() - global_position).normalized()
	
	if direction.length() > 0:
		# acelerate and handle max speed
		velocity = velocity.move_toward(direction * MAX_SPEED , ACCELERATION * delta)
	else :
		# stop
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	# check collitions
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() == null:
			continue
		if collision.get_collider().is_in_group("player"):
			collision.get_collider().hit(dmg_per_hit)
			healtComponent.die()
		
	move_and_slide()
	pass
	

func _on_healt_component_sg_death(_remaining_damage):
	queue_free()

func take_damage(ammount: float):
	print("dammage")
	if !healtComponent.is_death():
		healtComponent.hit(ammount)
	
func _on_mouse_entered():
	take_damage(1.0)


func _on_healt_component_sg_hit(_healt, _hit_taken):
	print("hit")
