"""
	MENUBUTTON.GD
	@auth tk
	@desc script for the button on the window bar that lets you get back to the world/level selection
"""

extends TextureButton



""" _ON_CLOSE_BUTTON_DOWN: detects if the button was pressed. actually it's not a close button, this is just unfortunate method naming. """

func _on_close_button_down():
	get_tree().change_scene("res://ui/WorldSelection.tscn")   # change scene to the world selection
