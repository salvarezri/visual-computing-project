class_name HealtComponent
extends Node

@export var init_max_healt: float = 10.0

# Signals
signal sg_max_healt_seted(previous: float, new: float)
signal sg_max_healt_rised(max_healt: float, remaning_heal:float)
signal sg_death(remaining_damage: float)
signal sg_hit(healt: float, hit_taken: float)
signal sg_heal(healt: float, heal_amount: float)
# Not implemented
signal sg_close_to_die(healt: float, percentage: float)


# Main variables
var max_healt: float
var curr_healt: float

func _ready():
	max_healt = init_max_healt
	curr_healt = max_healt
	
# Handling with max healt
func increase_max_healt_by_amount(amount:float) -> bool :
	if amount < 0 : return false 
	var previous = max_healt
	max_healt += amount
	sg_max_healt_seted.emit(previous,max_healt)
	return true
	
func decrease_max_healt_by_amount(amount:float) -> bool:
	if amount < 0 : return false 
	var previous = max_healt
	max_healt -= amount
	sg_max_healt_seted.emit(previous,max_healt)
	return true
	
func increase_max_healt_by_percentage(percentage:float) -> bool:
	if percentage < 0: return false
	var previous = max_healt
	max_healt *= percentage
	sg_max_healt_seted.emit(previous,max_healt)
	return true
	
func decrease_max_healt_by_percentage(percentage:float) -> bool:
	if percentage < 0 || percentage>1: return false
	var previous = max_healt
	max_healt *= 1.0 - percentage
	sg_max_healt_seted.emit(previous,max_healt)
	return true


# Handling hits and heals
func hit(amount: float) -> bool:
	if amount < 0 : return false 
	if amount >= curr_healt:
		var remaning = amount - curr_healt
		curr_healt = 0
		sg_hit.emit(curr_healt, amount - remaning)
		sg_death.emit(remaning)
		return true
	curr_healt -= amount
	sg_hit.emit(curr_healt, amount)
	return true
	
func heal(amount:float) -> bool:
	if amount < 0 : return false 
	if amount >= max_healt-curr_healt:
		var remaning = curr_healt + amount - max_healt
		curr_healt = max_healt
		sg_heal.emit(curr_healt, amount - remaning)
		sg_max_healt_rised.emit(curr_healt, remaning)
		return true
	curr_healt += amount
	sg_heal.emit(curr_healt, amount)
	return true
	
func die():
	sg_death.emit(0)
	curr_healt = 0
	
# get properties
func get_max_healt() -> float:
	return max_healt
	
func get_curr_healt() -> float:
	return curr_healt
	
func get_healt_percentage() -> float:
	return curr_healt/max_healt
	
func is_death(presition: float = 0.001) -> bool:
	return curr_healt <= 0 + presition
	
func has_max_healt(presition:float = 0.001)-> bool:
	return curr_healt >= max_healt-presition && curr_healt < max_healt+presition
