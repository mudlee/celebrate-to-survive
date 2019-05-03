extends Node2D

func _ready():
	print("Hello from godot");

func _input(event):
	if event.is_action_pressed("fireworks"):
		print("HAH")
	
