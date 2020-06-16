"""
	Lava.GD
	@auth ds
	@desc handles lava behaviour.
"""

extends EnemyStatic


""" _ON_AREA2D_AREA_ENTERED: detects if a body enters the spinner hitbox """
#   @param area: unused, filled in by the engine

func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "Player1":
		get_tree().get_current_scene().kill("kill: spinner")   # send kill request to LevelControls
