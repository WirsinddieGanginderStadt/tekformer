"""
	PAUSECREEN.GD
	@auth jm
"""

extends Control

func _physics_process(delta: float) -> void:
	if $MarginContainer/CenterContainer/VBoxContainer/TextureButton.is_hovered() == true:  #if the button is selected the focused pattern will appear 
		$MarginContainer/CenterContainer/VBoxContainer/TextureButton.grab_focus()
	if $MarginContainer/CenterContainer/VBoxContainer/TextureButton2.is_hovered() == true: #if the button is selected the focused pattern will appear 
		$MarginContainer/CenterContainer/VBoxContainer/TextureButton2.grab_focus()
	if $MarginContainer/CenterContainer/VBoxContainer/TextureButton3.is_hovered() == true: #if the button is selected the focused pattern will appear 
		$MarginContainer/CenterContainer/VBoxContainer/TextureButton3.grab_focus()
	if $MarginContainer/CenterContainer/VBoxContainer/TextureButton4.is_hovered() == true: #if the button is selected the focused pattern will appear 
		$MarginContainer/CenterContainer/VBoxContainer/TextureButton4.grab_focus()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"): #you can open the pause menu with the "Esc" Button
		$MarginContainer/CenterContainer/VBoxContainer/TextureButton.grab_focus() #if the pausecreen will open the first button will be selected
		get_tree().paused = not get_tree().paused #the cpmplete game will be paused
		visible = not visible


func _on_TextureButton_pressed() -> void: #the game will be continued 
	get_tree().paused = not get_tree().paused 
	visible = not visible


func _on_TextureButton2_pressed() -> void:
	pass # Replace with function body.


func _on_TextureButton3_pressed() -> void: 
	get_tree().paused = not get_tree().paused 
	get_tree().change_scene("res://ui/WorldSelection.tscn")


func _on_TextureButton4_pressed() -> void: #the game will be qitted
	get_tree().quit()
