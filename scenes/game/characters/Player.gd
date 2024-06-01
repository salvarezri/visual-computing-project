class_name Player
extends CharacterBody2D
signal hited()
signal energy_changed()
signal die
@export var ACCELERATION = 0
@export var MAX_SPEED = 0
@export var FRICTION = 0
@export_node_path("HealtComponent") var healt_comp_path
@export_node_path("EnergyComponent") var energy_comp_path
var healt_component : HealtComponent
var energy_component : EnergyComponent
var waiting_to_shot: bool = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("player")
	healt_component = get_node(healt_comp_path)
	energy_component = get_node(energy_comp_path)
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
func reload():
	healt_component.reload()
	energy_component.reload()
	
func hit(ammount):
	healt_component.hit(ammount)

func consume(ammount):
	energy_component.consume(ammount)

func _on_healt_component_sg_death(_remaining_damage):
	animation_player.play("die")
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
	animation_player.play("hit")

func can_consume(amount):
	return energy_component.can_consume(amount)
func _on_energy_component_sg_consumed_energy():
	energy_changed.emit()


func _on_energy_component_sg_restored_energy():
	energy_changed.emit()
	animation_player.play("recharge")


func _on_healt_component_sg_heal(healt, heal_amount):
	animation_player.play("heal")
	pass # Replace with function body.


func _on_animation_player_animation_finished(anim_name):
	if anim_name=="die":
		die.emit()
		animation_player.play("RESET")
	pass # Replace with function body.
func get_healt_component()->HealtComponent:
	return healt_component
	
func get_energy_component()-> EnergyComponent:
	return energy_component
