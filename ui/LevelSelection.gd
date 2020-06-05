"""
	LEVELSELECTION.GD
	@auth tk
	@desc changes the scene to the level that gets selected.
"""

extends TextureButton

var path = "res://data/levellock.json"
var data 

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
		if data["world1"][i] == true:
			get_tree().current_scene.get_node("Overlay"+i).visible = true
		if data["world1"][i] == false:
			get_tree().current_scene.get_node("Overlay"+i).visible = false

""" _ON_TEXTUREBUTTON_BUTTON_DOWN: detects a click on the button """

func _on_TextureButton_button_down():
	get_tree().current_scene.get_node("FadeOut").fadeout("res://levels/" + name + ".tscn")   # call function of fadeout node
