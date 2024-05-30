extends Area2D
@export var damage: float = 10
@onready var time_to_die: Timer= $Timer 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body: PhysicsBody2D):
	if body.has_method("take_damage"):
		body.take_damage(damage)


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
