"""
	LEVELSELECTION.GD
	@auth ds
	@desc creurns to worldselection
"""

extends TextureButton


""" _ON_TEXTUREBUTTON_BUTTON_DOWN: detects a click on the button """

func _pressed():
	print("fade")
	get_tree().current_scene.get_node("FadeOut").fadeout("res://ui/WorldSelection.tscn")   # call function of fadeout node
