"""
	NEXTLEVELTELEPORTER.GD
	@auth tk
	@desc teleports the player to the next level.
"""

extends StaticBody2D



""" _ON_AREA2D_AREA_ENTERED: detects if another area enters the hitbox of this object """
#   @param area: unused, filled in by the engine

func _on_Area2D_area_entered(area):
	get_tree().change_scene("res://levels/" + name + ".tscn")   # change scene. variable name = the name of the nextLevelTeleporter node. therefore, the nextLevelTeleporter node should be named after the next level (-> e.g. this level: 1-5, next level & node name: 1-6)
