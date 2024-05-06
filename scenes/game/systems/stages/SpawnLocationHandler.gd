class_name SpawnLocationHandler
extends Path2D

@onready var path_follow: PathFollow2D = $PathFollow2D


func get_mobs_location(number: int, spread: float, progress: float) -> Array[Vector2]:
	var locations: Array[Vector2] = []
	for i in number:
		path_follow.progress_ratio = progress+randf_range(-1,1)*spread
		locations.append(path_follow.position)
	return locations

