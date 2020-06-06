"""
	SLIME.GD
	@auth tk, jm
	@desc handles slime behaviour.
"""

extends EnemyLR



""" _ON_AREA2D_SIDE_BODY_ENTERED: detects side collisions with a body """
#   @param area: area of the collision object. unused.

func _on_Area2D_Side_body_entered(body) -> void:
	if not dead:
		if body.name == "Player1":
			get_tree().get_current_scene().kill("kill: slime")   # kill the player



""" _ON_AREA2D_TOP_AREA_ENTERED: detects top collisions with other area2d's """
#   @param area: area of the collision object. unused.

func _on_Area2D_Top_area_entered(area):
	dead = true
	animate_sprite()
	update_collisions()



""" ANIMATE_SPRITE: animates the slime sprite. """

func animate_sprite() -> void:
	if not dead:
		$AnimatedSprite.play("walk")
		# flip facing depending on movement direction:
		if speed.x > 0:
			$AnimatedSprite.flip_h = true
		elif speed.x < 0:
			$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("dead")
		$Timer.start()



""" UPDATE_COLLISIONS: updates the collisions in order to fix a bug. """

func update_collisions() -> void:
	# activate / deactivate collision boxes by moving them (as .disabled = true/false does not work for some reason)
	if dead:
		$CollisionShapeAlive.position.y =  0.709 - 1000.0   # moves collision box out of render distance
	else:
		$CollisionShapeAlive.position.y =  0.709            # moves collision box back



""" DEAD: gets called when the enemy dies. """

func dead():
	dead = true
	animate_sprite()
	update_collisions()
