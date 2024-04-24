extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# print(get_child_count())
	pass


func _on_polygon_by_mouse_new_step(step):
	pass


func _on_polygon_by_mouse_max_len_rised(_polygons):
	pass

func free_child_in_group(group:String):
	for child in get_children():
			if child.is_in_group(group):
				child.queue_free()
				
func _on_mouse_entered():
	pass # Replace with function body.


func _on_child_entered_tree(node):
	# print(get_child_count())
	pass # Replace with function body.
