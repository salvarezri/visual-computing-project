extends Node2D

@export var  power_scene: PackedScene
@export var active: bool = false
@export var group_name: String = "splash"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func  _input(event):
	if event is InputEventMouseButton and active:
		var new_power: Splash = power_scene.instantiate()
		new_power.position = event.position
		new_power.add_to_group(group_name)
		get_parent().add_child(new_power)
	
func set_power(power: int):

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
