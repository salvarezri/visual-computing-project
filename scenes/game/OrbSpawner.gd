extends Node2D

@export var ratio: float = 0.5 
@export var orb_scene: PackedScene
@export var restore: int = 4
@export var time_to_die: int = 4
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	 # Get the viewport size
	var viewport_size = get_viewport().get_visible_rect().size

	# Generate random x and y positions within the viewport size
	var random_x = randi() % int(viewport_size.x)
	var random_y = randi() % int(viewport_size.y)
	print(random_x, " ", random_y)

	# Create an instance of the scene
	var orb: Orb = Orb.new()
	var type = randf()
	print(orb.position)
	orb.position = Vector2(random_x, random_y)
	print(orb.position)
	var color = Color.html("#ff0546") if type < ratio else Color.html("#0ce6f2")
	print(color)
	orb.color = color
	print(orb.color)
	orb.type = "HEAL" if type < ratio else "ENERGY"
	print(orb.type)
	orb.restore = restore
	print(orb.restore)
	orb.time_to_die = time_to_die
	print(orb.time_to_die)
	# Set the position of the instance
	print(orb.position)
	# Add the instance to the current scene
	$Node2D.add_child(orb)
	pass # Replace with function body.
