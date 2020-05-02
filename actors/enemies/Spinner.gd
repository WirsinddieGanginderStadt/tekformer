"""
	SPINNER.GD
	@auth tk
	@desc handles spinner behaviour.
"""

extends StaticBody2D


""" _ON_AREA2D_AREA_ENTERED: detects if another area enters the spinner hitbox """
#   @param area: unused, filled in by the engine

func _on_Area2D_area_entered(area):
	get_tree().get_current_scene().kill("kill: spinner")   # send kill request to LevelControls



""" RESET: called on level reset (= death) """

func reset():
	pass   # no enemy reset required
