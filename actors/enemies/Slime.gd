"""
	SLIME.GD
	@auth tk
	@desc handles slime behaviour.
"""

extends KinematicBody2D



""" VARIABLES """
var defaultPos   := Vector2(    0.0, 0.0)   # default position, gets set in _ready()
var defaultSpeed := Vector2(-2500.0, 0.0)   # default speed

var speed := defaultSpeed   # current speed
var dead  := false   # is the slime dead? used for sprite animations & collision behaviour



""" _READY: gets called on object instantiation """

func _ready():
	defaultPos = position   # set defaultPos to the position of the object



""" _PHYSICS_PROCESS: called once per frame. does main physics calculations """
#   @param delta [float]: time elapsed between two frames. filled in by the engine.

func _physics_process(delta: float) -> void:
	if not dead:
		move_and_slide(speed * delta)                         # move slime
		if position.x < defaultPos.x - 200 and speed.x < 0:   # slime is allowed to move 200 into -x direction
			speed.x = -speed.x                                # flip movement direction
		elif position.x > defaultPos.x and speed.x > 0:       # slime is behind (+x direction) the original position
			speed.x = -speed.x                                # flip movement direction
		animate_sprite()



""" _ON_AREA2D_SIDE_AREA_ENTERED: detects side collisions with other area2d's """
#   @param area: area of the collision object. unused.

func _on_Area2D_Side_area_entered(area):
	if not dead:
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




""" UPDATE_COLLISIONS: updates the collisions in order to fix a bug. """

func update_collisions() -> void:
	# activate / deactivate collision boxes by moving them (as .disabled = true/false does not work for some reason)
	if dead:
		$CollisionShapeAlive.position.y =  0.709 - 1000.0   # moves collision box out of render distance
	else:
		$CollisionShapeAlive.position.y =  0.709            # moves collision box back



""" RESET: resets the slime. called by LevelControls """

func reset():
	yield(get_tree().create_timer(0.05), "timeout")   # small delay before resetting the slime (bugfix). don't put too much slimes into one level, otherwise, some unexpected long delays might happen.
	# reset variables:
	position = defaultPos
	speed = defaultSpeed
	dead = false
	animate_sprite()
	update_collisions()
