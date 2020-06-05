"""
	NEXTLEVELTELEPORTER.GD
	@auth tk
	@desc teleports the player to the next level.
"""

extends StaticBody2D

var path = "res://data/levellock.json"
var data 

func _ready() -> void:
	load_game()

func load_game():
	var file = File.new()
	file.open(path, file.READ)
	var text = file.get_as_text()
	data = parse_json(text)
	file.close()
	print(data)

""" _ON_AREA2D_AREA_ENTERED: detects if another area enters the hitbox of this object """
#   @param area: unused, filled in by the engine

#func _on_Area2D_area_entered(area):
#	print("Finished Level " + get_tree().current_scene.name + " within " + get_tree().current_scene.get_node("HUD").get_node("Timer").text.replace("Timer: ", "") + " seconds.")   # log needed time
#	get_tree().current_scene.get_node("FadeOut").fadeout("res://levels/" + name + ".tscn")   # call function of fadeout node


func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "Player1":
		print("Finished Level " + get_tree().current_scene.name + " within " + get_tree().current_scene.get_node("HUD").get_node("Timer").text.replace("Timer: ", "") + " seconds.")   # log needed time
		get_tree().current_scene.get_node("FadeOut").fadeout("res://levels/" + name + ".tscn")   # call function of fadeout node
		
