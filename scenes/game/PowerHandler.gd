extends Node


@export_node_path("GraphicInterface") var user_interface
@export_node_path("PolygonByMouse") var polygon_by_mouse
@export_node_path("PowerGenerator") var power_generator

@onready var wall_timer: Timer = $TimerWall
@onready var ray_timer: Timer = $TimerRay
@onready var splash_timer: Timer = $TimerSplash

var active = "RAY"
var ui_node:GraphicInterface
var poly_mouse_node:PolygonByMouse
var pow_gen_node: PowerGenerator
var mouse_active = true

var wall_cooldown = 3
var splash_cooldown = 3
var ray_cooldown = 3



# Called when the node enters the scene tree for the first time.
func _ready():
	ui_node = get_node(user_interface)
	poly_mouse_node = get_node(polygon_by_mouse)
	pow_gen_node = get_node(power_generator)
	desactivate_splash()
	desactivate_wall()
	activate_ray()

func activate_power(powername:String):
	if powername == active:
		return
	desactivate(active)
	if powername== "RAY":
		active = "RAY"
		pow_gen_node.set_power(1)
		if ray_timer.time_left > 0 :
			return
		activate_ray()
	elif powername == "WALL":
		active = "WALL"
		if wall_timer.time_left > 0 :
			return
		activate_wall()
	elif  powername == "SPLASH":
		active = "SPLASH"
		pow_gen_node.set_power(0)
		if splash_timer.time_left > 0:
			return
		activate_splash()

func activate_ray():
	pow_gen_node.active = true
	pow_gen_node.set_power(1)

func activate_splash():
	pow_gen_node.active = true
	pow_gen_node.set_power(0)

func activate_wall():
	poly_mouse_node.active = true

func desactivate_ray():
	pow_gen_node.active = false

func desactivate_splash():
	pow_gen_node.active = false

func desactivate_wall():
	poly_mouse_node.active = false
	
func desactivate(power_name:String):
	if power_name== "RAY":
		desactivate_ray()
	elif power_name == "WALL":
		desactivate_wall()
	elif  power_name == "SPLASH":
		desactivate_splash()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(wall_timer.time_left)
	ui_node.set_times(
		get_percentage(wall_cooldown,wall_timer.time_left),
		get_percentage(splash_cooldown,splash_timer.time_left),
		get_percentage(ray_cooldown,ray_timer.time_left),
	)
	
func get_percentage(max: int, remaining: float):
	return ((max-remaining)/max)*100

func _on_game_ui_power_selected(power_name):
	activate_power(power_name)


func _on_nav_reg_mouse_shape_max_len():
	wall_timer.start(wall_cooldown)
	desactivate(active)
	

func _on_power_generator_generated():
	if active == "SPLASH":
		splash_timer.start(splash_cooldown)
	elif active == "RAY":
		ray_timer.start(ray_cooldown)
	desactivate(active)


func _on_timer_wall_timeout():
	poly_mouse_node.get_parent().reset()
	if active == "WALL":
		activate_wall()


func _on_timer_splash_timeout():
	if active == "SPLASH":
		activate_splash()


func _on_timer_ray_timeout():
	if active == "RAY":
		activate_ray()


