"""
	SkinSelection.GD
	@auth ds
	@desc handels SkinSelection
"""


extends OptionButton



var skin := 1

# Called when the node enters the scene tree for the first time.

func _ready():
	add_item("Hans", 0)
	add_item("Kara", 1)

func _process(delta):
	skin = get_selected_id()

