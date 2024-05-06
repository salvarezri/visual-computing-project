class_name VelocityComponent
extends Node

@export var init_max_speed: float = 100
@export var init_acc: float = 100

var max_speed: float
var acc_coeficient: float
var speed: float
var velocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	acc_coeficient = init_acc
	max_speed = init_max_speed
	speed = 0.0
	velocity = Vector2.UP
	
# TODO: all following set and get functions
func increase_max_speed(_percentage: float):
	pass
func decrease_max_speed(_percentage: float):
	pass
func increase_acc(_amount:float):
	pass
func decrease_acc(_amount:float):
	pass
func get_velocity():
	pass
func get_acc():
	pass
func get_max_speed():
	pass
func get_speed():
	pass
func get_direction():
	pass
# TODO: all folowing physics movement function
func move_towards(_direction: Vector2):
	pass
func move_to(_position: Vector2):
	pass
func move():
	pass
