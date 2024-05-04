extends CharacterBody2D

@export var speed: float = 300
@export var acc: float = 7
@export var target: Player
@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var healtComponent: HealtComponent = $HealtComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = get_global_mouse_position()
	nav.target_position = target.position
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction* speed,acc*delta)

	move_and_slide()


func _on_healt_component_sg_death(_remaining_damage):
	print(":c")


func _on_mouse_entered():
	if !healtComponent.is_death():
		healtComponent.hit(1.0)


func _on_healt_component_sg_hit(_healt, _hit_taken):
	print("hit")
