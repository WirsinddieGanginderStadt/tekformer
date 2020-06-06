"""
	FLY.GD
	@auth lm
	@desc handles fly behaviour.
"""

extends EnemyLR



""" _ON_AREA2D_BODY_ENTERED: detects side collisions with a body """
#   @param area: area of the collision object. unused.

func _on_Area2D_body_entered(body) -> void:
	if body.name == "Player1":
		get_tree().get_current_scene().kill("kill: fly")   # kill the player



""" ANIMATE_SPRITE: animates the fly sprite. """

func animate_sprite() -> void:
	$AnimatedSprite.play("fly1")
	# flip facing depending on movement direction:
	if speed.x > 0:
		$AnimatedSprite.flip_h = true
	elif speed.x < 0:
		$AnimatedSprite.flip_h = false
