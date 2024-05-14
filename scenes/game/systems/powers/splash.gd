class_name  Splash
extends Area2D

@export var time_to_die :float = 5
@export var damage: float = 1.0
@export var time_to_damage: float = 1.0

@onready var timer_to_die: Timer = $TimerToDie
@onready var timer_to_hit: Timer = $TimerToHit

# Called when the node enters the scene tree for the first time.
func _ready():
	timer_to_die.wait_time = time_to_die
	timer_to_hit.wait_time = time_to_damage
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func hit_enemies_inside():
	for enemie in get_overlapping_areas():
		if enemie.has_method("take_damage"):
			enemie.take_damage(damage)	

func _on_timer_to_hit_timeout():
	hit_enemies_inside()
		


func _on_timer_to_die_timeout():
	queue_free()
