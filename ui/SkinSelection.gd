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
	
	$Female1.visible = false
	$Male1.visible = false
	
	writing_skin_in_config(skin)

func _process(delta):
	skin = get_selected_id()
	writing_skin_in_config(skin)
	displaying_Skin(skin)
	

func writing_skin_in_config(_skin_cfg: int):
	config.load("config.cfg")
	config.set_value("player","skin",_skin_cfg)
	config.save("config.cfg")
	
func displaying_Skin(_skin_to_display: int):
	$Female1.visible = false
	$Male1.visible = false
	if _skin_to_display == 0:
		$Male1.visible = true
		$Female1.visible = false
	if _skin_to_display == 1:
		$Male1.visible = false
		$Female1.visible = true

