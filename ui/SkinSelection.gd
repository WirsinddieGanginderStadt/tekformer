"""
	SkinSelection.GD
	@auth ds
	@desc handels SkinSelection
"""


extends OptionButton


var skin := 0  # lokal skin var

var config = ConfigFile.new() #var config File for later writing in it (empty)


""" Called when the node enters the scene tree for the first time. """
func _ready():
	# add Skins in Skin_OptionButton
	add_item("Hans", 0)
	add_item("Kara", 1)
	add_item("Indi", 2)
	add_item("Alex", 3)
	add_item("Zombey", 4)
	
	#seting all skin Sprites-skins  unvisible
	$Female1.visible = false
	$Male1.visible = false
	$Adventurer1.visible = false
	$Soldier1.visible = false
	$Zombie1.visible = false
	
	writing_skin_in_config(skin)
	
	
"""_PROCESS: called once per frame when main processing. main processing"""
func _process(delta):
	
	skin = get_selected_id()     #getting skin from Skin_OptionButton. id used for skin
	writing_skin_in_config(skin) #method call 
	displaying_Skin(skin)        #method call
	
"""WRITING_SKIN_IN_CONFIG: writes @para _skin_cfg in the .cfg config file"""
# @param _skin_cfg : var to write in .cfg 

func writing_skin_in_config(_skin_cfg: int):
	# calls method in config from Config class in godot  should be self explanatory
	config.load("config.cfg")
	config.set_value("player","skin",_skin_cfg)
	config.save("config.cfg")

"""DISPLAYING SKIN: shows the right skin-sprite  """
# @param _skin_to_change 

func displaying_Skin(_skin_to_display: int):
	var children := get_children()
	for i in  children:
		i.visible = false
	
	children[_skin_to_display].visible = true
