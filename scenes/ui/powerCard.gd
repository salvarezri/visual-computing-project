extends PanelContainer
signal selected(power_name)
@onready var power_name_node: Label = $V/Name
@onready var button_img_node:TextureButton = $V/ButtonImg
@onready var progress_bar_node: TextureProgressBar = $V/Progress
@onready var ene_label_node: Label = $V/H/V/EnergyLabel
@onready var pow_label_node: Label = $V/H/V2/PowerLable
@onready var tim_label_node: Label = $V/H/V3/TimeLable

@export var power_name: String = "<power_name>"
@export var button_imgs: Array[ImageTexture]
@export var energy_cost: int = 4
@export var dmg_power: int = 4
@export var waiting_time: int = 4
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_progress(progress:int):
	pass 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func activate():
	pass
func desactivate():
	pass
	
func _on_button_img_pressed():
	selected.emit(power_name)
	activate
	print("pressed")
	pass # Replace with function body.
