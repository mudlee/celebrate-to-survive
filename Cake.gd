extends Area2D

func _physics_process(delta):
	if len(get_overlapping_bodies()) > 0:
		for body in get_overlapping_bodies():
			if body.name == "Player":
				get_tree().change_scene("res://won.tscn")