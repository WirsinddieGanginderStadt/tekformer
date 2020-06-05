extends Node

var coins_collected := 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	for i in get_child_count():
		if get_child(i)._is_coin_collected :
			coins_collected = coins_collected +1
		get_child(i)._is_coin_collected = false
