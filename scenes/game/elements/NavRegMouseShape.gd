extends NavigationRegion2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_polygon_by_mouse_new_step(_step):
	bake_navigation_polygon()
