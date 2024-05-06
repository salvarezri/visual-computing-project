class_name StagesTimer
extends Node

@export var stages_number: int = 10
@export var sub_stages: int = 7
@export var time_of_stage: float = 15.0
@export var boss_stage: bool= true

@onready var sub_stage_timer: Timer = $SubStageTimer

signal sub_stage_time(stage:int, last_sub_stage: bool, boss_stage: bool)


var curr_stage: int = 0
var curr_sub_stage: int = 0
var on_stage: bool = false
func _ready():
	if sub_stages < 1: sub_stages = 1
	on_stage = false
	sub_stage_timer.one_shot = true

func get_curr_stage() -> int:
	return curr_stage

func start_stages():
	curr_stage = 0
	nex_stage()

func nex_stage():
	curr_stage += 1
	curr_sub_stage = 1
	on_stage = true
	sub_stage_timer
	start_timer()
func start_timer():
	sub_stage_timer.start(time_of_stage/sub_stages)
func is_boss_stage() ->bool:
	return curr_stage >= stages_number && boss_stage

func _on_sub_stage_timer_timeout():
	if curr_sub_stage >= sub_stages:
		sub_stage_time.emit(curr_stage,true, is_boss_stage())
		on_stage = false
		return
	sub_stage_time.emit(curr_stage, false, is_boss_stage())
	curr_sub_stage +=1
	start_timer()

func step() -> bool:
	print("aaaaaaaa")
	if curr_stage >= stages_number:
		return false
	nex_stage()
	return true
	
	
