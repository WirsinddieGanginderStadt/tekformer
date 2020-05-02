"""
	LEVELCONTROLS.GD
	@auth tk
	@desc handles most of the things that happen in a level (deaths etc).
"""

extends Node2D



""" VARIABLES """

var deaths := 0   # amount of deaths



""" _READY: called on object instantiation. """

func _ready():
	print("[level]: ", name)             # log level to console
	$HUD/Level.text = "Level: " + name   # show current level in hud



""" _PHYSICS_PROCESS: called once per frame. does main physics calculations. """
#    @param delta [float]: time between two frames, filled in by the engine

func _physics_process(delta):
	if $Player1.position.y > 1500:
		kill("void")   # kill player when in the void



""" KILL: kills the player. """
#   @param reason [String]: the reason why the player got killed. used to log the death to the console.

func kill(reason: String):
	$Player1.position = Vector2(100.0, -55.0)                     # reset player position
	$Player1._velocity = Vector2.ZERO                             # reset player velocity
	deaths += 1                                                   # increase death counter
	print("[death] [", name, "]: #", deaths, " (", reason, ")")   # log death message
	$HUD/Deaths.text = "Deaths: " + String(deaths)                # update death hud on screen
	reset_enemies()                                               # reset enemies



""" RESET_ENEMIES: resets the state of all enemies """

func reset_enemies():
	for i in $Enemies.get_children():   # go through all children of the Enemies node
		i.reset()   # call reset method of enemies
