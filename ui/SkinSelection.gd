"""
	SkinSelection.GD
	@auth ds
	@desc handels SkinSelection
"""


extends OptionButton



var skin := 0
var config = ConfigFile.new()
# Called when the node enters the scene tree for the first time.

func _ready():
	add_item("Hans", 0)
	add_item("Kara", 1)
	
	writing_skin_in_config(skin)

func _process(delta):
	skin = get_selected_id()
	writing_skin_in_config(skin)

func writing_skin_in_config(_skin_cfg: int):
	config.load("config.cfg")
	config.set_value("player","skin",_skin_cfg)
	config.save("config.cfg")

