"""
	FADEOUT.GD
	@auth tk
	@desc fades out the scene for a nice transition.
"""

extends Node2D



""" FADEOUT: fades out the scene. """

func fadeout(nextSceneLocation: String) -> void:
	$AnimationPlayer.play("fadeout")   # play fadeout animation
	yield(get_tree().create_timer(0.3), "timeout")   # timeout before scene change
	get_tree().change_scene(nextSceneLocation)   # change scene to nextSceneLocation
