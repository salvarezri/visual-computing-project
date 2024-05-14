class_name Enemy
extends Area2D

@export var max_speed: float = 2.0
@export var acc: float = 0.01
@export var target: Player
@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var healtComponent: HealtComponent = $HealtComponent

var velocity:= Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Get the direction marked by the navigation agent
	var direction = get_global_mouse_position()
	nav.target_position = target.position
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	# Move the character
	var change: Vector2 = direction+velocity.normalized()*acc
	
	velocity = (velocity + change).normalized()*max_speed
	position = position + velocity
	
	


func _on_healt_component_sg_death(_remaining_damage):
	queue_free()

func take_damage(ammount: float):
	if !healtComponent.is_death():
		healtComponent.hit(ammount)
	
func _on_mouse_entered():
	take_damage(1.0)


func _on_healt_component_sg_hit(_healt, _hit_taken):
	print("hit")
