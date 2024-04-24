extends Node2D

@onready var polygonByMouse = $PolygonByMouse
var polyGroup = "grupoNo1"
# Called when the node enters the scene tree for the first time.
func _ready():
	polygonByMouse.set_access_group(polyGroup)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_child_entered_tree(node):
	if node.is_in_group(polyGroup):
		print("asdf")
		pass
	pass
