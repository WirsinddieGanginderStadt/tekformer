"""
Coin.gd
@auth JM

"""
extends Area2D


onready var anim_player: AnimationPlayer = get_node("AnimationPlayer") # reference to the animation




func _on_body_entered(body: Node) -> void: # if the player collides with the coin will disapear 
	anim_player.play("fade_out") #  the associated animation is played
