"""
	CLOSEBUTTON.GD
	@auth tk
	@desc script for the close button on the window bar
"""

extends TextureButton



""" _ON_CLOSE_BUTTON_DOWN: detects if the button was pressed. """

func _on_close_button_down():
	get_tree().quit()   # close game
