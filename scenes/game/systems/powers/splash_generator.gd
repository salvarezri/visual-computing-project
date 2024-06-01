class_name PowerGenerator
extends Node2D
signal generated()
@export var power_scenes: Array[PackedScene]
@export var power_selector: int = 0
@export var active: bool = false
@export var group_name: String = "power"
@export_node_path("Player") var player_path
var player_node: Player 
var splash_cost = 4
var ray_Cost = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	player_node = get_node(player_path)
	pass

func  _input(event:InputEvent):
	var ammount = splash_cost if power_selector == 0 else ray_Cost
	if event.is_action("left_click_presed") and active and player_node.can_consume(ammount):
		var ev: InputEventMouseButton = event
		if ev.is_released():
			return
		var new_power = power_scenes[power_selector].instantiate()
		new_power.position = event.position
		new_power.add_to_group(group_name)
		get_parent().add_child(new_power)
		generated.emit()
		
		
	
func set_power(power: int):
	power_selector = power 
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
