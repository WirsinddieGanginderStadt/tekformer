"""
Coin.gd
@auth jm
"""
extends Area2D


onready var anim_player: AnimationPlayer = get_node("AnimationPlayer") # reference to the animation


var _is_coin_collected := false


func _on_body_entered(body: Node) -> void: # if the player collides with the coin will disapear 
	_is_coin_collected = true
	anim_player.play("fade_out") #  the associated animation is played
