class_name GraphicInterface
extends CanvasLayer
signal mouse_entered
signal mouse_exited
signal power_selected(power_name:String)
signal restarted()
var on_mouse= false
@export_node_path("PowerHandler") var power_handler_path

var power_handler_node: PowerHandler
# Called when the node enters the scene tree for the first time.
func _ready():
	if power_handler_path:
		power_handler_node = get_node(power_handler_path)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if power_handler_node:
		set_power_states(power_handler_node.get_state_powers())
	pass

func set_power_states(states: Array[bool]):
	$Powers/M/H/WallPowerCard3.set_power_state(states[0])
	$Powers/M/H/SplashPowerCard2.set_power_state(states[1])
	$Powers/M/H/RayPowerCard.set_power_state(states[2])
	pass

func _on_ray_power_card_selected(power_name):
	power_selected.emit(power_name)

func _on_splash_power_card_2_selected(power_name):
	power_selected.emit(power_name)

func _on_wall_power_card_3_selected(power_name):
	power_selected.emit(power_name)


func _on_powers_mouse_entered():
	mouse_entered.emit()
	pass # Replace with function body.

func set_times(wall, splash, ray):
	$Powers/M/H/RayPowerCard.set_time(ray)
	$Powers/M/H/SplashPowerCard2.set_time(splash)
	$Powers/M/H/WallPowerCard3.set_time(wall)
	
func set_life(life):
	$Stats/MarginContainer/GridContainer/ProgressBarLife.value = life

func setup_life(min,max):
	$Stats/MarginContainer/GridContainer/ProgressBarLife.min_value = min
	$Stats/MarginContainer/GridContainer/ProgressBarLife.max_value = max
	$Stats/MarginContainer/GridContainer/ProgressBarLife.value = max

func set_energy(energy):
	$Stats/MarginContainer/GridContainer/ProgressBarMana.value = energy
	
func setup_energy(min,max):
	$Stats/MarginContainer/GridContainer/ProgressBarMana.min_value = min
	$Stats/MarginContainer/GridContainer/ProgressBarMana.max_value = max
	$Stats/MarginContainer/GridContainer/ProgressBarMana.value = max
	
func _on_powers_mouse_exited():
	mouse_exited.emit()
	pass # Replace with function body.
func update_score(score):
	$Score.text = String.num_int64(score)
	
func game_over(score:int, max:int):
	$PanelContainer.visible = true
	$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Label.text = String.num_int64(score)
	$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/Label.text = String.num_int64(max)
func _on_texture_button_pressed():
	restarted.emit()
	$PanelContainer.visible = false
	
