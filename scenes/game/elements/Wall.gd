extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# print(get_child_count())
	pass


func _on_polygon_by_mouse_new_step(step):
	free_child_in_group("shape_wall")
	$PolygonByMouse.call("generate_Shape","shape_wall")
	if step == 2:
		free_child_in_group("collision_wall")
		$PolygonByMouse.call("generate_Collition","collision_wall")


func _on_polygon_by_mouse_max_len_rised(_polygons):
	free_child_in_group("collision_wall")
	$PolygonByMouse.call("generate_Collition","collision_wall")

func free_child_in_group(group:String):
	for child in get_children():
			if child.is_in_group(group):
				child.queue_free()
				
func _on_mouse_entered():
	print("mouseeeee")
	pass # Replace with function body.
