class_name Power
extends Resource
enum PowerTypes {RAY_POWER, SPLASH_POWER, WALL_POWER}
@export var power: PowerTypes
@export var powername :String
@export var cool_down: int
@export var dmg_per_hit: int
@export var icons: Array[Texture2D]
