extends Node2D
@export var powers: Array[Power]

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnHandler.start()
	var max_h = $Player.get_max_healt()
	$GameUi.setup_life(0,max_h)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_player_hited():
	print($Player.get_cur_healt())
	$GameUi.set_life($Player.get_cur_healt())
	pass # Replace with function body.
