class_name Player
extends CharacterBody2D
signal hited()
@export var ACCELERATION = 0
@export var MAX_SPEED = 0
@export var FRICTION = 0
@export_node_path("HealtComponent") var healt_comp_path
@export_node_path("EnergyComponent") var energy_comp_path
var healt_component : HealtComponent
var energy_component : EnergyComponent
var waiting_to_shot: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("player")
	healt_component = get_node(healt_comp_path)
	pass # Replace with function body.  

func _input(_event):
	pass

func _physics_process(delta):
	motion_ctrl(delta)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rotation_ctrl()

func rotation_ctrl():
	look_at(get_global_mouse_position())
	# ajust rotation
	rotation = rotation-PI/2

func motion_ctrl(delta):
	# moovement
	# detect input
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if direction.length() > 0:
		# acelerate and handle max speed
		velocity = velocity.move_toward(direction * MAX_SPEED , ACCELERATION * delta)
	else :
		# stop
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_slide()

func hit(ammount):
	healt_component.hit(ammount)

func consume(ammount):
	energy_component.consume(ammount)

func _on_healt_component_sg_death(_remaining_damage):
	pass # Replace with function body.

func get_cur_healt():
	return healt_component.get_curr_healt()

func get_cur_energy():
	return energy_component.get_curr_energy()
	
func get_max_energy():
	return energy_component.get_max_energy()
	
func get_max_healt():
	return healt_component.get_max_healt()
	
func _on_healt_component_sg_hit(healt, _hit_taken):
	hited.emit()
	pass # Replace with function body.
