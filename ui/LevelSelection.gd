"""
	LEVELSELECTION.GD
	@auth tk
	@desc changes the scene to the level that gets selected.
"""

extends TextureButton



""" _ON_TEXTUREBUTTON_BUTTON_DOWN: detects a click on the button """

func _on_TextureButton_button_down():
	get_tree().current_scene.get_node("FadeOut").fadeout("res://levels/" + name + ".tscn")   # call function of fadeout node
