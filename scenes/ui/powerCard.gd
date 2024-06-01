extends PanelContainer
signal selected(power_name)
@onready var power_name_node: Label = $V/Name
@onready var button_img_node:TextureButton = $V/ButtonImg
@onready var progress_bar_node: TextureProgressBar = $V/Progress
@onready var ene_label_node: Label = $V/H/V/EnergyLabel
@onready var pow_label_node: Label = $V/H/V2/PowerLable
@onready var tim_label_node: Label = $V/H/V3/TimeLable

@export var power_name: String = "<power_name>"
@export var button_imgs: Array[Texture2D]
@export var energy_cost: int = 4
@export var dmg_power: int = 4
@export var waiting_time: int = 4
var on_panel = false
# Called when the node enters the scene tree for the first time.
func _ready():
	power_name_node.text = power_name
	ene_label_node.text = String.num_int64(energy_cost)
	pow_label_node.text = String.num_int64(dmg_power)
	tim_label_node.text = String.num_int64(waiting_time)
	if button_imgs.size()>=4:
		button_img_node.texture_normal = button_imgs[0]
		button_img_node.texture_hover = button_imgs[1]
		button_img_node.texture_pressed = button_imgs[2]
		button_img_node.texture_disabled = button_imgs[3]


func update_progress(progress:int):
	pass 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func activate():
	pass
func desactivate():
	pass

func set_power_state(state:bool):
	if button_img_node.disabled != !state:
		button_img_node.disabled = !state
	
func _on_button_img_pressed():
	selected.emit(power_name)
	activate
	pass # Replace with function body.
func set_time(value):
	$V/Progress.value = value
