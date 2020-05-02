"""
	LEVELSELECTION.GD
	@auth tk
	@desc changes the scene to the level that gets selected.
"""

extends TextureButton



""" _ON_TEXTUREBUTTON_BUTTON_DOWN: detects a click on the button """

func _on_TextureButton_button_down():
	get_tree().change_scene("res://levels/" + name + ".tscn")   # change scene to the level selected. variable name = name of the button node. therefore, the button should be named after the level it should go to (e.g. level 1-5 -> button name: 1-5)
