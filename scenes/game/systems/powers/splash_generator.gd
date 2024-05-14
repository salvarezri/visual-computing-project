extends Node2D

@export var  splaschScene: PackedScene
@export var active: bool = false
@export var group_name: String = "splash"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func  _input(event):
	if event is InputEventMouseButton and active:
		var new_splash: Splash = splaschScene.instantiate()
		new_splash.position = event.position
		new_splash.add_to_group(group_name)
		get_parent().add_child(new_splash)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
