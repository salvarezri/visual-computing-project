class_name PolygonByMouse
extends Node2D

signal max_len_rised(polygons: Array[PackedVector2Array])
signal new_step(step: Steps)

@export var polygon_width: float = 20
@export var sampling_distance : float = 20
@export var max_lenght: float = 1000
@export var limit_max_lenght: bool = true
@export var active: bool = true
@export var only_final: bool = false
@export var only_get_polygon: bool = false
@export var access_group:String = "PolygonGenerated"

@export var selected_node_type: NodeType = NodeType.POLYGON_2D

enum NodeType {COLLISION_POLYGON_2D, POLYGON_2D}
enum Steps {START,MID,FINAL}

var prev_pos : Vector2 = Vector2.ZERO
var prev_prev_pos: Vector2 = Vector2.ZERO
var is_clicked
var state = false
var lines_points = []
var carry_angle:float = -20
var last_line : int = -1
var curr_len: float = 0
var group_gen: String


func reset():
	group_gen = gen_unique_string(25)
	prev_pos  = Vector2.ZERO
	prev_prev_pos= Vector2.ZERO
	state = false
	lines_points = []
	carry_angle = -20
	last_line = -1
	curr_len = 0
	
func set_access_group(new_group:String, set_before: bool = false):
	if  set_before:
		for child in get_parent().get_children():
			if child.is_in_group(access_group):
				child.remove_from_group(access_group)
				child.add_to_group(new_group)
	access_group = new_group
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Power")
	group_gen = gen_unique_string(25)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# check len restrictions and verify if its active
	if !(curr_len >= max_lenght and limit_max_lenght) and active:
		update_clicked()
		manage_states()
		check_distance()


func check_distance():
	var len_of_lines = 0
	for line_points in lines_points:
		var len_of_line = 0
		for i in len(line_points):
			# pass if line is only a point
			if len(line_points) > 1:
				len_of_line += line_points[i-1].distance_to(line_points[i])
		len_of_lines += len_of_line
	if len_of_lines >= max_lenght and limit_max_lenght:
		max_len_rised.emit(get_polygons())
		if only_final:
			update_polygon()
	curr_len = len_of_lines
	
func manage_states():
	var distant_to_mouse = prev_pos.distance_to(get_viewport().get_mouse_position())
	if !state and is_clicked:
		first_point()
	elif is_clicked and state and distant_to_mouse >= sampling_distance:
		mid_points()
	elif !is_clicked and state:
		final_point()

func first_point():
	# start drawing
	last_line += 1
	prev_pos = get_viewport().get_mouse_position()
	prev_prev_pos = prev_pos
	# asign a specific value to carry to update it on the nex point
	# because we need 2 points to update it and now only have one
	carry_angle = -20
	lines_points.append([prev_pos])
	state = true
	if !(only_final or only_get_polygon):
		group_gen = gen_unique_string(25)
		update_polygon()
	new_step.emit(Steps.START)

	
func mid_points():
	# update last two mouse positions
	prev_prev_pos = prev_pos
	prev_pos = get_viewport().get_mouse_position()
	var curr_angle: float
	# Second point by the mouse, update carry angle
	if carry_angle == -20:
		# first
		carry_angle =  prev_prev_pos.angle_to_point(prev_pos)
	# common case
	else:
		# if the rotation is higer tha 90 degrees, split the line and start another
		curr_angle = prev_prev_pos.angle_to_point(prev_pos)
		# TODO if cur line is too long, broke
		if abs(carry_angle - curr_angle) > PI/2 || get_len_of_line(lines_points[last_line])> 150.0:
			broke_polygon()
			carry_angle = curr_angle
	lines_points[last_line].append(get_viewport().get_mouse_position())
	if !(only_final or only_get_polygon):
		update_polygon()
	new_step.emit(Steps.MID)

func final_point():
	# not clicked, but drawin the polygon, last point
	state = false
	lines_points[last_line].append(get_viewport().get_mouse_position())
	if !(only_final or only_get_polygon):
		update_polygon()
	new_step.emit(Steps.FINAL)

func broke_polygon():
	var lastpoint : Vector2 = lines_points[last_line][-1]
	lines_points.append([lastpoint])
	last_line += 1
	group_gen = gen_unique_string(25)

func update_polygon():
	delete_polygon_children()
	add_polygon()

func delete_polygon_children():
	var x = 0
	for i in range(get_parent().get_child_count()-1,0,-1):
		var child = get_parent().get_children()[i]
		x+=1
		if child.is_in_group(group_gen):
			child.queue_free()

func add_polygon():
	for arr in obtain_polygon(last_line):
		# create a new polygon node, then update his polygon and add it as a child
		arr = arr_to_local(arr)
		var polygon
		match selected_node_type:
			NodeType.COLLISION_POLYGON_2D:
				polygon = CollisionPolygon2D.new()
			NodeType.POLYGON_2D:
				polygon = Polygon2D.new()
		polygon.polygon = arr
		polygon.add_to_group(group_gen)
		polygon.add_to_group(access_group)
		get_parent().add_child(polygon)
		
	
func obtain_polygon(i:int) -> Array[PackedVector2Array]:
	# convert a line into a polygon
	# Can return multiple polygons to represent only one line
	var new_polygon = Geometry2D.offset_polyline(lines_points[i],polygon_width, Geometry2D.JOIN_ROUND, Geometry2D.END_ROUND) 
	return new_polygon.duplicate()

func update_clicked():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		is_clicked = true
	else:
		is_clicked = false
	

func get_len() -> float:
	return curr_len
	
func get_len_alized() -> float:
	# can return more than 1 if pass max len
	return curr_len/ max_lenght
	
func activate():
	active = true
func desactivate ():
	active = false

var ascii_letters_and_digits = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
func gen_unique_string(length: int) -> String:
	var result = ""
	for i in range(length):
		result += ascii_letters_and_digits[randi() % ascii_letters_and_digits.length()]
	return result

func get_polygons(local:bool = false) -> Array[PackedVector2Array]:
	# iterate over all the lines
	var polygons: Array[PackedVector2Array] = [] 
	for index_line in last_line + 1:
		# method can return more than one polygon to represent one line
		for arr in obtain_polygon(index_line):
			if local:
				arr = arr_to_local(arr)
			# create a new polygon node, then update his polygon and add it as a child
			polygons.append(arr)
	return polygons
func arr_to_local(arr: PackedVector2Array) -> PackedVector2Array:
	var copy = arr.duplicate()
	for i in len(copy):
		copy[i]=to_local(copy[i])
	return copy
	
func arr_to_global(arr: PackedVector2Array) -> PackedVector2Array:
	var copy = arr.duplicate()
	for i in len(copy):
		copy[i]=to_global(copy[i])
	return copy

func generate_Collition(group:String =group_gen):
	for index_line in last_line + 1:
		# method can return more than one polygon to represent one line
		for arr in obtain_polygon(index_line):
			# create a new polygon node, then update his polygon and add it as a child
			arr = arr_to_local(arr)
			var polygon = CollisionPolygon2D.new()
			polygon.polygon = arr
			polygon.add_to_group(group)
			polygon.add_to_group(access_group)
			get_parent().add_child(polygon)
			
func generate_Shape(group:String =group_gen):
	for index_line in last_line + 1:
		# method can return more than one polygon to represent one line
		for arr in obtain_polygon(index_line):
			# create a new polygon node, then update his polygon and add it as a child
			arr = arr_to_local(arr)
			var polygon = Polygon2D.new()
			polygon.polygon = arr
			polygon.add_to_group(group)
			polygon.add_to_group(access_group)
			get_parent().add_child(polygon)
func get_group_gen() -> String:
	return group_gen
			
func get_len_of_line(line: PackedVector2Array) -> float:
	if len(line)<2:
		return 0
	var cur_length = 0
	for i in len(line)-1:
		cur_length += line[i].distance_to(line[i+1])
	return cur_length
	
