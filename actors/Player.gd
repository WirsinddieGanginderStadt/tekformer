"""
	PLAYER.GD
	@auth tk
	@desc handles player movement
"""

extends KinematicBody2D



""" VARIABLES """

const FLOOR_NORMAL := Vector2.UP   # normal floor direction (required in order to function)

export var speed := Vector2(700.0, 1300.0)   # max speed of the player - can be altered in the inspector, tab "script variables"
export var gravity := 3500.0   # speed of the player - can be altered in the inspector, tab "script variables"

var _velocity := Vector2.ZERO   # velocity is set to 0 at the beginning



""" _READY: called on object instantiation. """

func _ready():
	Engine.set_target_fps(Engine.get_iterations_per_second())   # set targetted fps



""" _PHYSICS_PROCESS: called once per frame. does main physics calculations. """
#    @param delta [float]: time between two frames, filled in by the engine

func _physics_process(delta: float) -> void:
	var is_jump_interrupted := Input.is_action_just_released("P1-JUMP") and _velocity.y < 0.0   # test if jump got interrupted (jump button released)
	var direction := get_direction()                                                            # get player movement direction
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)       # calculate movement velocity
	var snap := Vector2.DOWN * 60.0 if direction.y == 0.0 else Vector2.ZERO                     # snap to floor if not jumping, else don't snap
	_velocity.y += gravity * delta                                                              # apply gravity

	# move player and return resulting velocity to _velocity:
	_velocity = move_and_slide_with_snap(
		_velocity, snap, FLOOR_NORMAL, true
	)
	animate_sprite()   # animate player sprite



""" GET_DIRECTION: determines in which direction the player should go """
#   @return [Vector2]: left-right movement, up-down movement

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("P1-RIGHT") - Input.get_action_strength("P1-LEFT"),   # calculates where the player should move (left-right)
		-Input.get_action_strength("P1-JUMP") if is_on_floor() and Input.is_action_just_pressed("P1-JUMP") else 0.0   # jump up if player on floor and jump button pressed, else don't jump
	)



""" CALCULATE_MOVE_VELOCITY: calculates the velocity which the player uses to move """
#   @param current_velocity [Vector2]: current velocity of the player.
#          direction [Vector2]:        direction the player is moving to (func get_direction())
#          speed [Vector2]:            max speed of the player
#          is_jump_interrupted [bool]: is the jump button released?
#   @return [Vector2]: velocity of the player

func calculate_move_velocity(current_velocity: Vector2, direction: Vector2, speed: Vector2, is_jump_interrupted: bool) -> Vector2:
	var velocity: = current_velocity
	velocity.x = speed.x * direction.x       # set x velocity to max speed (x) * the direction the player is going to (left-right)
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y   # set y velocity to max speed (y) * the direction the player is goint to (up-down)
	if is_jump_interrupted:
		velocity.y = 0.0                     # set y velocity to 0 if jump is interrupted, so that gravity can apply correctly
	return velocity



""" ANIMATE: animates the player sprite """

func animate_sprite():
	# play animations depending on current state. should be self-explanatory.
	if _velocity.y < 0:
		$AnimatedSprite.play("jump")
	elif _velocity.y > 0 and Input.is_action_pressed("P1-JUMP"):
		$AnimatedSprite.play("jump")
	elif _velocity.y > 0:
		$AnimatedSprite.play("fall")
	elif Input.is_action_pressed("P1-LEFT") and Input.is_action_pressed("P1-RIGHT"):
		$AnimatedSprite.play("stand")
	elif Input.is_action_pressed("P1-LEFT"):
		$AnimatedSprite.play("walk")
	elif Input.is_action_pressed("P1-RIGHT"):
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("stand")

	# flip sprite depending on where the player faces/goes to
	if Input.is_action_pressed("P1-LEFT") and Input.is_action_pressed("P1-RIGHT"):
		pass   # skip if block if both left and right buttons are pressed
	elif Input.is_action_pressed("P1-LEFT"):
		$AnimatedSprite.set_flip_h(true)
	elif Input.is_action_pressed("P1-RIGHT"):
		$AnimatedSprite.set_flip_h(false)
