"""
	NEXTLEVELTELEPORTER.GD
	@auth tk, jm
	@desc teleports the player to the next level.
"""

extends StaticBody2D

var path = "res://data/levellock.json" #path to the json file
var data  #var for the json file
export var world = 1

func _ready() -> void:
	load_file()

func load_file():
	var file = File.new() #local var
	file.open(path, file.READ) #json file gets written on the var
	var text = file.get_as_text() #the json file on the var file gets readen out
	data = parse_json(text) #the json file gets parset
	file.close() #the will be closed

func save_file():
	var file #local var
	file = File.new() 
	file.open(path, File.WRITE) #the changes will be written in the json file
	file.store_line(to_json(data)) 
	file.close() #the file will be closed

func edit_file():
	data["world"+String(world)][name] = false #the boolean willl be changed

""" _ON_AREA2D_AREA_ENTERED: detects if another area enters the hitbox of this object """
#   @param area: unused, filled in by the 

func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "Player1":
		print("Finished Level " + get_tree().current_scene.name + " within " + get_tree().current_scene.get_node("HUD").get_node("Timer").text.replace("Timer: ", "") + " seconds.")   # log needed time
		get_tree().current_scene.get_node("FadeOut").fadeout("res://levels/" + name + ".tscn")   # call function of fadeout nod
		if name == "WorldSelection":
			get_tree().change_scene("res://ui/WorldSelection.tscn")
		else:
			edit_file() 
			save_file()
