"""
	LEVELSELECTION.GD
	@auth jm
	@desc handles the locksystem of the levels
"""

extends Node2D

var path = "res://data/levellock.json"
var data 
export var world = 1

func _ready() -> void:
	load_game()
	button_disable()

func load_game():
	var file = File.new()
	file.open(path, file.READ)
	var text = file.get_as_text()
	data = parse_json(text)
	file.close()

func button_disable():
	for i in ["1-2","1-3","1-4","1-5","1-6","1-7","1-8","1-9","1-10","1-11","1-12"]:
		if data["world"+String(world)][i] == false:
			get_node("Overlay/Overlay" +String(i)).visible = false
		if data["world"+String(world)][i] == true:
			get_node("Overlay/Overlay" +String(i)).visible = true
