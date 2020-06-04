"""
	WORLDSELECTION.GD
	@auth tk
	@desc changes the scene to the level selection of the selected world.
"""

extends TextureButton



""" _ON_TEXTUREBUTTON_BUTTON_DOWN: detects a click on the button """

func _on_TextureButton_button_down():
	get_tree().change_scene("res://ui/LevelSelection" + name + ".tscn")   # change scene to the level selection. variable name = name of the button node. therefore, the button should be named after the world it should go to (e.g. world 3 -> button name: 3)
