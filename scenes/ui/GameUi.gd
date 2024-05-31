class_name GraphicInterface
extends CanvasLayer
signal mouse_entered
signal mouse_exited
signal power_selected(power_name:String)
var on_mouse= false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	#print(on_panels_mouse, on_mouse)
	pass

	

func _on_ray_power_card_selected(power_name):
	power_selected.emit(power_name)

func _on_splash_power_card_2_selected(power_name):
	power_selected.emit(power_name)

func _on_wall_power_card_3_selected(power_name):
	power_selected.emit(power_name)


func _on_powers_mouse_entered():
	print("entered")
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
	
func _on_powers_mouse_exited():
	print("exited")
	mouse_exited.emit()
	pass # Replace with function body.
