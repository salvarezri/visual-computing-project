extends NavigationRegion2D
signal max_len()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func reset():
	for child in get_children():
		if !child.is_in_group("Power"):
			child.queue_free()
	$PolygonByMouse.reset()
	await get_tree().create_timer(0.1).timeout
	bake_navigation_polygon()
	
func finish_reset():
	await reset()
func _on_polygon_by_mouse_new_step(_step):
	await get_tree().create_timer(0.01).timeout
	bake_navigation_polygon()


func _on_polygon_by_mouse_max_len_rised(polygons):
	max_len.emit()
