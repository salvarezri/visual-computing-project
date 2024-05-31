extends Node2D
@export var powers: Array[Power]

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnHandler.start()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

