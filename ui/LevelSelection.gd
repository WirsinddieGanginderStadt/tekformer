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
	button_disabled()

func load_game():
	var file = File.new()
	file.open(path, file.READ)
	var text = file.get_as_text()
	data = parse_json(text)
	file.close()


func save_game():
	var file
	file = File.new()
	file.open(path, File.WRITE)
	file.store_line(to_json(data))
	file.close()

func button_disabled():
	if data["world1"]["1-2"] == false:
		$Buttons/TextureButton.visible = true

""" _ON_TEXTUREBUTTON_BUTTON_DOWN: detects a click on the button """

func _on_TextureButton_button_down():
	get_tree().current_scene.get_node("FadeOut").fadeout("res://levels/" + name + ".tscn")   # call function of fadeout node
