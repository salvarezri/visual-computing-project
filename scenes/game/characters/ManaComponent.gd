class_name EnergyComponent
extends Node

@export var init_max_energy: float = 10.0
@export var restore_per_second = 4

# Signals
signal sg_max_energy_seted()
signal sg_max_energy_rised()
signal sg_no_energy()
signal sg_consumed_energy()
signal sg_restored_energy()
# Not implemented
signal sg_close_to_no_energy(energy: float, percentage: float)


# Main variables
var max_energy: float
var curr_energy: float

func _ready():
	max_energy = init_max_energy
	curr_energy = max_energy
	
# Handling with max energy
func increase_max_energy_by_amount(amount:float) -> bool :
	if amount < 0 : return false 
	var previous = max_energy
	max_energy += amount
	sg_max_energy_seted.emit(previous,max_energy)
	return true
	
func decrease_max_energy_by_amount(amount:float) -> bool:
	if amount < 0 : return false 
	var previous = max_energy
	max_energy -= amount
	sg_max_energy_seted.emit(previous,max_energy)
	return true
	
func increase_max_energy_by_percentage(percentage:float) -> bool:
	if percentage < 0: return false
	var previous = max_energy
	max_energy *= percentage
	sg_max_energy_seted.emit(previous,max_energy)
	return true
	
func decrease_max_energy_by_percentage(percentage:float) -> bool:
	if percentage < 0 || percentage>1: return false
	var previous = max_energy
	max_energy *= 1.0 - percentage
	sg_max_energy_seted.emit(previous,max_energy)
	return true


# Handling hits and heals
func consume(amount: float) -> bool:
	if amount < 0 : return false 
	if amount >= curr_energy:
		var remaning = amount - curr_energy
		curr_energy = 0
		sg_consumed_energy.emit()
		sg_no_energy.emit(remaning)
		return true
	curr_energy -= amount
	sg_consumed_energy.emit()
	return true
	
func heal(amount:float) -> bool:
	if amount < 0 : return false 
	if amount >= max_energy-curr_energy:
		var remaning = curr_energy + amount - max_energy
		curr_energy = max_energy
		sg_restored_energy.emit()
		sg_max_energy_rised.emit()
		return true
	curr_energy += amount
	sg_restored_energy.emit()
	return true
	
func clear_energy():
	sg_no_energy.emit(0)
	curr_energy = 0
	
# get properties
func get_max_energy() -> float:
	return max_energy
	
func get_curr_energy() -> float:
	return curr_energy
	
func get_energy_percentage() -> float:
	return curr_energy/max_energy
	
func is_death(presition: float = 0.001) -> bool:
	return curr_energy <= 0 + presition
	
func has_max_energy(presition:float = 0.001)-> bool:
	return curr_energy >= max_energy-presition && curr_energy < max_energy+presition

func _on_timer_timeout():
	if !has_max_energy:
		heal(restore_per_second)
