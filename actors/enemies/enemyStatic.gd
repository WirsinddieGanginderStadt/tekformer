"""
	ENEMYSTATIC.GD
	@desc base class for all static enemies.
	@auth tk
"""

extends StaticBody2D
class_name EnemyStatic



""" RESET: called on level reset (= death) """
#   > OVERWRITE

func reset():
	pass   # normally no enemy reset is required
