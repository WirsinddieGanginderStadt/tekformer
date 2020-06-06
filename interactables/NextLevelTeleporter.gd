"""
	NEXTLEVELTELEPORTER.GD
	@auth tk
	@desc teleports the player to the next level.
"""

extends StaticBody2D



""" _ON_AREA2D_AREA_ENTERED: detects if another area enters the hitbox of this object """
#   @param area: unused, filled in by the engine

func _on_Area2D_area_entered(area):
	print("Finished Level " + get_tree().current_scene.name + " within " + get_tree().current_scene.get_node("HUD").get_node("Timer").text.replace("Timer: ", "") + " seconds.")   # log needed time
	if name == "WorldSelection":
		get_tree().current_scene.get_node("FadeOut").fadeout("res://ui/WorldSelection.tscn")   # call function of fadeout node
	else:
		get_tree().current_scene.get_node("FadeOut").fadeout("res://levels/" + name + ".tscn")   # call function of fadeout node
