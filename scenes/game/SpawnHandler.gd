class_name SpawnHandler
extends Node

@export var enemies: Array[PackedScene]
@export var number: int = 4
@export_node_path("Player") var player

@onready var stage_timer: StagesTimer = $StagesTimer
@onready var spawn_location_Handler: SpawnLocationHandler = $SpawnLocationHandler

# Called when the node enters the scene tree for the first time.
func _ready():
	stage_timer.start_stages()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_stages_timer_sub_stage_time(stage, last_sub_stage, boss_stage):
	var locations: Array[Vector2] = spawn_location_Handler.get_mobs_location(number,0.1,randf())
	for location in locations:
		var enemy = enemies[0].instantiate() as Enemy
		enemy.position = location
		enemy.target = get_node(player)
		get_parent().add_child(enemy)
	if last_sub_stage:
		print("last sub stage")
		stage_timer.step()
