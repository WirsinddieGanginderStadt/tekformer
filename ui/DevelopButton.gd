"""
	CREDITS.GD
	@auth ds
	@desc unlocks all Level for Testing
"""


extends TextureButton



var path = "res://data/levellock.json" #path to the json file
var data  #var for the json file

func _ready() -> void:
	load_file()


func _on_TextureButton_button_down() -> void:
	edit_file()
	save_file()
	print("All Levels unlocked")


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
	for i in 3:
		for a in 12:
			data["world" + String(i + 1)][ String(i + 1)+ "-" + String(a + 1)] = false #the boolean willl be changed
