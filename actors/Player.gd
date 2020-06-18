"""
	PLAYER.GD
	@auth tk, jm , ds
	@desc handles player movement
"""

extends KinematicBody2D



""" VARIABLES """

const FLOOR_NORMAL := Vector2.UP   # normal floor direction (required in order to function)

const FIREBALL = preload("res://Items/Fireball.tscn")

export var speed := Vector2(700.0, 1300.0)   # max speed of the player - can be altered in the inspector, tab "script variables"
export var gravity := 3500.0   # speed of the player - can be altered in the inspector, tab "script variables"

var _velocity := Vector2.ZERO   # velocity is set to 0 at the beginning

var justStarted := true   # has the game just started / restarted

var jump_count = 0  # counts the jumps 
const extrajumps = 2 # a maximum of 1 double jump
var jumpforce = -1000  # the power of the double jumps

export var skin := 0 #selected Skin(0:Hans;1:Kara;2:Indi)

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
	# player cannot move on level start/restart:
	if justStarted:
		if is_on_floor():
			justStarted = false
		else:
			position.x = 100
	
	animate_sprite(skin)   # animate player sprite
	
	if jump_count < extrajumps and Input.is_action_just_pressed("P1-JUMP"): # only double if jump_count is <2
		_velocity.y=jumpforce # the power of the jump
		jump_count += 1  # counts 1 after a double jump
	
	if Input.is_action_just_pressed("P1-RIGHT"): #direction of the player
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
			
	if Input.is_action_just_pressed("P1-LEFT"): #directoin of the player
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	
	
	if Input.is_action_just_pressed("ui_accept"): #if accept is pressed the player shoots a fireball
		var fireball = FIREBALL.instance() 
		if sign($Position2D.position.x) == 1:
			fireball.set_fireball_direction(1)
		else:
			fireball.set_fireball_direction(-1)
		get_parent().add_child(fireball)
		fireball.position = $Position2D.global_position

func _process(delta):
	if is_on_floor(): # resets jump_count if the player hits the ground
		jump_count = 0  



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

func animate_sprite(_skin: int):
	# play animations depending on current state. should be self-explanatory.
	$AnimatedSpriteMale1.visible = false
	$AnimatedSpriteFemale1.visible = false
	$AnimatedSpriteAdventurer1.visible = false
	$AnimatedSpriteSoldier1.visible = false
	
	if skin == 0:
		
		$AnimatedSpriteMale1.visible = true
		
	
		if _velocity.y < 0:
			$AnimatedSpriteMale1.play("jump")
		elif _velocity.y > 0 and Input.is_action_pressed("P1-JUMP"):
			$AnimatedSpriteMale1.play("jump")
		elif _velocity.y > 0:
			$AnimatedSpriteMale1.play("fall")
		elif Input.is_action_pressed("P1-LEFT") and Input.is_action_pressed("P1-RIGHT"):
			$AnimatedSpriteMale1.play("stand")
		elif Input.is_action_pressed("P1-LEFT"):
			$AnimatedSpriteMale1.play("walk")
		elif Input.is_action_pressed("P1-RIGHT"):
			$AnimatedSpriteMale1.play("walk")
		elif Input.is_action_pressed("P1-CHEER"):
			$AnimatedSpriteMale1.play("cheer")
		else:
			$AnimatedSpriteMale1.play("stand")
	
		# flip sprite depending on where the player faces/goes to
		if Input.is_action_pressed("P1-LEFT") and Input.is_action_pressed("P1-RIGHT"):
			pass   # skip if block if both left and right buttons are pressed
		elif Input.is_action_pressed("P1-LEFT"):
			$AnimatedSpriteMale1.set_flip_h(true)
		elif Input.is_action_pressed("P1-RIGHT"):
			$AnimatedSpriteMale1.set_flip_h(false)
			
			
	if skin == 1:
		
		$AnimatedSpriteFemale1.visible = true
	
		if _velocity.y < 0:
			$AnimatedSpriteFemale1.play("jump")
		elif _velocity.y > 0 and Input.is_action_pressed("P1-JUMP"):
			$AnimatedSpriteFemale1.play("jump")
		elif _velocity.y > 0:
			$AnimatedSpriteFemale1.play("fall")
		elif Input.is_action_pressed("P1-LEFT") and Input.is_action_pressed("P1-RIGHT"):
			$AnimatedSpriteFemale1.play("stand")
		elif Input.is_action_pressed("P1-LEFT"):
			$AnimatedSpriteFemale1.play("walk")
		elif Input.is_action_pressed("P1-RIGHT"):
			$AnimatedSpriteFemale1.play("walk")
		elif Input.is_action_pressed("P1-CHEER"):
			$AnimatedSpriteFemale1.play("cheer")
		else:
			$AnimatedSpriteFemale1.play("stand")
	
		# flip sprite depending on where the player faces/goes to
		if Input.is_action_pressed("P1-LEFT") and Input.is_action_pressed("P1-RIGHT"):
			pass   # skip if block if both left and right buttons are pressed
		elif Input.is_action_pressed("P1-LEFT"):
			$AnimatedSpriteFemale1.set_flip_h(true)
		elif Input.is_action_pressed("P1-RIGHT"):
			$AnimatedSpriteFemale1.set_flip_h(false)
	if skin == 2:
		
		$AnimatedSpriteAdventurer1.visible = true
	
		if _velocity.y < 0:
			$AnimatedSpriteAdventurer1.play("jump")
		elif _velocity.y > 0 and Input.is_action_pressed("P1-JUMP"):
			$AnimatedSpriteAdventurer1.play("jump")
		elif _velocity.y > 0:
			$AnimatedSpriteAdventurer1.play("fall")
		elif Input.is_action_pressed("P1-LEFT") and Input.is_action_pressed("P1-RIGHT"):
			$AnimatedSpriteAdventurer1.play("stand")
		elif Input.is_action_pressed("P1-LEFT"):
			$AnimatedSpriteAdventurer1.play("walk")
		elif Input.is_action_pressed("P1-RIGHT"):
			$AnimatedSpriteAdventurer1.play("walk")
		elif Input.is_action_pressed("P1-CHEER"):
			$AnimatedSpriteAdventurer1.play("cheer")
		else:
			$AnimatedSpriteAdventurer1.play("stand")
	
		# flip sprite depending on where the player faces/goes to
		if Input.is_action_pressed("P1-LEFT") and Input.is_action_pressed("P1-RIGHT"):
			pass   # skip if block if both left and right buttons are pressed
		elif Input.is_action_pressed("P1-LEFT"):
			$AnimatedSpriteAdventurer1.set_flip_h(true)
		elif Input.is_action_pressed("P1-RIGHT"):
			$AnimatedSpriteAdventurer1.set_flip_h(false)
	
	if skin == 3:
		
		$AnimatedSpriteSoldier1.visible = true
	
		if _velocity.y < 0:
			$AnimatedSpriteSoldier1.play("jump")
		elif _velocity.y > 0 and Input.is_action_pressed("P1-JUMP"):
			$AnimatedSpriteSoldier1.play("jump")
		elif _velocity.y > 0:
			$AnimatedSpriteSoldier1.play("fall")
		elif Input.is_action_pressed("P1-LEFT") and Input.is_action_pressed("P1-RIGHT"):
			$AnimatedSpriteSoldier1.play("stand")
		elif Input.is_action_pressed("P1-LEFT"):
			$AnimatedSpriteSoldier1.play("walk")
		elif Input.is_action_pressed("P1-RIGHT"):
			$AnimatedSpriteSoldier1.play("walk")
		elif Input.is_action_pressed("P1-CHEER"):
			$AnimatedSpriteSoldier1.play("cheer")
		else:
			$AnimatedSpriteSoldier1.play("stand")
	
		# flip sprite depending on where the player faces/goes to
		if Input.is_action_pressed("P1-LEFT") and Input.is_action_pressed("P1-RIGHT"):
			pass   # skip if block if both left and right buttons are pressed
		elif Input.is_action_pressed("P1-LEFT"):
			$AnimatedSpriteSoldier1.set_flip_h(true)
		elif Input.is_action_pressed("P1-RIGHT"):
			$AnimatedSpriteSoldier1.set_flip_h(false)



""" KILL: kills the player """

func kill() -> void:
	position = Vector2(100.0, -55.0)   # reset player position
	_velocity = Vector2.ZERO           # reset player velocity
	justStarted = true                 # set justStarted so that player can't move on level restart
