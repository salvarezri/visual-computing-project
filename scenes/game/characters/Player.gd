class_name Player
extends CharacterBody2D

signal hit

@export var ACCELERATION = 0
@export var MAX_SPEED = 0
@export var FRICTION = 0

var waiting_to_shot: bool = false
var speed = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.  

func _input(event):
	pass

func _physics_process(delta):
	motion_ctrl(delta)
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")*speed
	

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
	pass
