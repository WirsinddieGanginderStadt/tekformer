"""
Coin.gd
@auth jm, ds 
@desc coin animations and collection
"""
extends Area2D


onready var anim_player: AnimationPlayer = get_node("AnimationPlayer") # reference to the animation


var _is_coin_collected := false  #var for counting the collected coins: false if not collected yet


func _on_body_entered(body: Node) -> void: # run if the player collides with the coin
	_is_coin_collected = true   #collects the coin
	anim_player.play("fade_out") #  the associated animation is played: coin dissapears


#WIP
func reseting_Coin():
	anim_player.stop(true)
	_is_coin_collected = false
	print("coin",name,"reset")
