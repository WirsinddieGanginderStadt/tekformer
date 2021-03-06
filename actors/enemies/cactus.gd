"""
	CACTUS.GD
	@auth lm
	@desc handles spinner behaviour.
"""

extends EnemyStatic


""" _ON_AREA2D_AREA_ENTERED: detects if a body enters the cactus hitbox """
#   @param area: unused, filled in by the engine

func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "Player1":
		get_tree().get_current_scene().kill("kill: cactus")   # send kill request to LevelControls
