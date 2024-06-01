class_name Orb
extends Area2D

@export var restore: int = 1
@export var time_to_die: int = 5
@export var color: Color
@export var type: String

@onready var timer_to_die: Timer = $TimerToDie
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite = $Sprite2D

var taked = false
# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(800,800)
	pass
func setup():
	$Sprite2D.modulate = color
	animation_player.play("appear")
	timer_to_die.start(time_to_die)
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_to_die_timeout():
	animation_player.play("die")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "appear":
		timer_to_die.start(time_to_die)
	elif anim_name == "die":
		queue_free()
		pass


func _on_body_entered(body:Node2D):
	if body.is_in_group("Player") && !taked:
		if type == "HEAL":
			body.get_healt_component().heal(restore)
		elif  type == "ENERGY":
			body.get_energy_component().heal(restore)
		animation_player.play("die")
		taked = true


func _on_timer_timeout():
	setup()
	pass # Replace with function body.
