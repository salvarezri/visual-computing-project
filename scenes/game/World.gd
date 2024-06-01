extends Node2D
@export var powers: Array[Power]

@onready var player:Player = $Player
# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnHandler.start()
	var max_h = player.get_max_healt()
	$GameUi.setup_life(0,max_h)
	var max_e = player.get_max_energy()
	$GameUi.setup_energy(0,max_e)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_player_hited():
	print(player.get_cur_healt())
	$GameUi.set_life(player.get_cur_healt())
	pass # Replace with function body.


func _on_player_energy_changed():
	print(player.get_cur_energy())
	$GameUi.set_energy(player.get_cur_energy())
	pass # Replace with function body.
