extends Area2D

func _physics_process(delta):
	if len(get_overlapping_bodies()) > 0:
		get_tree().change_scene("res://won.tscn")