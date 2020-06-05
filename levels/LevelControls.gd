"""
	LEVELCONTROLS.GD
	@auth tk, ds
	@desc handles most of the things that happen in a level (deaths etc).
"""

extends Node2D



""" VARIABLES """

var deaths := 0   # amount of deaths
var level_timer := 0.0 # timer 
var _coins_collected := 0

var _skin := 0 # skin
var config = ConfigFile.new()




""" _READY: called on object instantiation. """

func _ready():
	
	#getting skin info out of config and setting the Player Skin 
	config.load("config.cfg")
	_skin = config.get_value("player", "skin", 0)
	config.save("config.cfg")
	$Player1.skin = _skin
	print("[current_Skin]: ", String(_skin))

	
	print("[level]: ", name)             # log level to console
	$HUD/Level.text = "Level: " + name   # show current level in hud
	
	level_timer = 0.0 # reseting timer



""" _PHYSICS_PROCESS: called once per frame when physiks-processing. does main physics calculations. """
#    @param delta [float]: time between two frames, filled in by the engine

func _physics_process(delta):
	
	if $Player1.position.y > 1500:
		kill("void")   # kill player when in the void



""" _PROCESS: called once per frame when processing. """
#    @param delta [float]: time between two frames, filled in by the engine

func _process(delta: float):
	
	_coins_collected = $AllCoins.coins_collected # getting var out of AllCoins and writting it into LevelControls
	$HUD/Coins.text = "Coins: " + String(_coins_collected) # Writing Coins into HUD
	
	level_timer += delta #incresing timer by delta
	var timer_length := String(int(level_timer)).length() + 3            # calculats whole number length of level_timer +3
	$HUD/Timer.text = "Timer: " + String(level_timer).left(timer_length) # updates Timer in Hub only showing 2 decimals


""" KILL: kills the player and resets the level. """
#   @param reason [String]: the reason why the player got killed. used to log the death to the console.

func kill(reason: String):
	$Player1.kill()                                               # kill player
	deaths += 1                                                   # increase death counter
	print("[death] [", name, "]: #", deaths, " (", reason, ")")   # log death message
	$HUD/Deaths.text = "Deaths: " + String(deaths)                # update death hud on screen
	reset_enemies()                                               # reset enemies
	level_timer = 0.0                                             # reseting timer
	_coins_collected = 0                                          # reseting coins
	$AllCoins.coins_collected = 0
	$AllCoins.reseting_all_Coins()
	



""" RESET_ENEMIES: resets the state of all enemies """

func reset_enemies():
	for i in $Enemies.get_children():   # go 	@desc summary of all coins in one Level to count them if collectedthrough all children of the Enemies node
		i.reset()   # call reset method of enemies
