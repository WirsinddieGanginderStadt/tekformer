"""
	FLY.GD
	@auth lm
	@desc handles fly behaviour.
"""

extends KinematicBody2D



""" VARIABLES """
var defaultPos   := Vector2(    0.0, 0.0)   # default position, gets set in _ready()
var defaultSpeed := Vector2(-2500.0, 0.0)   # default speed

var speed := defaultSpeed   # current speed





""" _READY: gets called on object instantiation """

func _ready():
	defaultPos = position   # set defaultPos to the position of the object



""" _PHYSICS_PROCESS: called once per frame. does main physics calculations """
#   @param delta [float]: time elapsed between two frames. filled in by the engine.

func _physics_process(delta: float) -> void:
		move_and_slide(speed * delta)                         # move fly
		if position.x < defaultPos.x - 200 and speed.x < 0:   # fly is allowed to move 200 into -x direction
			speed.x = -speed.x                                # flip movement direction
		elif position.x > defaultPos.x and speed.x > 0:       # fly is behind (+x direction) the original position
			speed.x = -speed.x                                # flip movement direction
		animate_sprite()




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













