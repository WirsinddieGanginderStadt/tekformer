"""
	ENEMYLR.GD
	@desc base class for all enemies that move left/right.
	@auth tk
"""

extends KinematicBody2D
class_name EnemyLR



""" VARIABLES """
var defaultPos   := Vector2(    0.0, 0.0)   # default position, gets set in _ready()
export var defaultSpeed := Vector2(-2500.0, 0.0)   # default speed
export var maxMovement := 200   # max distance the enemy can move

var speed := defaultSpeed   # current speed
var dead  := false   # is the enemy dead? used for sprite animations & collision behaviour




""" _READY: gets called on object instantiation """

func _ready():
	defaultPos = position   # set defaultPos to the position of the object



""" _PHYSICS_PROCESS: called once per frame. does main physics calculations """
#   @param delta [float]: time elapsed between two frames. filled in by the engine.

func _physics_process(delta: float) -> void:
	if not dead:
		move_and_slide(speed * delta)                         # move slime
		if position.x < defaultPos.x - maxMovement and speed.x < 0:   # enemy is allowed to move 'maxMovement' (default: 200) into -x direction
			speed.x = -speed.x                                # flip movement direction
		elif position.x > defaultPos.x and speed.x > 0:       # enemy is behind (+x direction) the original position
			speed.x = -speed.x                                # flip movement direction
		animate_sprite()
	set_sync_to_physics(false)



""" ANIMATE_SPRITE: animates the slime sprite. """
#   > OVERWRITE

func animate_sprite() -> void:
	pass



""" UPDATE_COLLISIONS: updates the collisions in order to fix a bug some enemies have. """
#   > OVERWRITE

func update_collisions() -> void:
	pass



""" RESET: resets the enemy. called by LevelControls """

func reset():
	yield(get_tree().create_timer(0.05), "timeout")   # small delay before resetting the slime (bugfix). don't put too much slimes into one level, otherwise, some unexpected long delays might happen.
	# reset variables:
	position = defaultPos
	speed = defaultSpeed
	dead = false
	animate_sprite()
	update_collisions()


""" DEAD: gets activated when the enemy dies. """
#   > OVERWRITE

func dead():
	pass
