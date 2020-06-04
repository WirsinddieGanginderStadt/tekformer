"""
	FPS.GD
	@auth jm

"""
extends MarginContainer

func _physics_process(delta: float) -> void:
	$HBoxContainer/VBoxContainer/Label.text = "FPS: " + str(Performance.get_monitor(Performance.TIME_FPS)) #monitor the current FPS
