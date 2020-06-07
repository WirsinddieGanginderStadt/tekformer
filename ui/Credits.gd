"""
	CREDITS.GD
	@auth tk
	@desc handles behaviour in the credit screen.
"""

extends TextureButton



""" _ON_TEXTUREBUTTON_BUTTON_DOWN: detects klicks on the back to worldselection button. """

func _on_TextureButton_button_down() -> void:
	get_tree().change_scene("res://ui/WorldSelection.tscn")
