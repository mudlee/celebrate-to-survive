extends Control

func _input(event):
	if event.is_action_pressed("reload"):
		get_tree().change_scene("res://Root.tscn")
