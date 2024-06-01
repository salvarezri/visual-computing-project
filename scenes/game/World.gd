extends Node2D
@export var powers: Array[Power]

@onready var player:Player = $Player
var score: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnHandler.start()
	var max_h = player.get_max_healt()
	$GameUi.setup_life(0,max_h)
	var max_e = player.get_max_energy()
	$GameUi.setup_energy(0,max_e)

func reload():
	for child in get_children():
		if child is Enemy:
			child.queue_free()
	player.reload()
	player.position = Vector2(960,540)
	$NavRegMouseShape.reset()
	$SpawnHandler.start()
	var max_h = player.get_max_healt()
	$GameUi.setup_life(0,max_h)
	var max_e = player.get_max_energy()
	$GameUi.setup_energy(0,max_e)
	score = 0
	$TimerScore.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_player_hited():
	$GameUi.set_life(player.get_cur_healt())
	pass # Replace with function body.


func _on_player_energy_changed():
	$GameUi.set_energy(player.get_cur_energy())
	pass # Replace with function body.


func _on_player_die():
	$TimerScore.stop()
	if score >= Constants.max_score:
		Constants.max_score = score
	$GameUi.game_over(score, Constants.max_score )
	pass # Replace with function body.


func _on_timer_score_timeout():
	score += 1
	$GameUi.update_score(score)


func _on_game_ui_restarted():
	reload()
