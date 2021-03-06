extends Node2D

export var idle_duration = 1.0
export var move_to = Vector2.ZERO

onready var tween = $MoveTween
onready var mesh = $Platform/MeshInstance2D

const COLORS = ["#ed6aac","#4446c8","#704089","#bac3f5"]

var speed = randi()%200+50
var move_from
var follow
var fireworks_active = false

func _ready():
	move_from = position
	follow = position
	mesh.modulate = Color(COLORS[randi()%4+0])
	
	init_tween()


func _physics_process(delta):
	position = position.linear_interpolate(follow, 0.075)


func fireworks_active():
	tween.stop_all()


func fireworks_not_active():
	tween.resume_all()


func init_tween():
	var duration = move_to.length()/ float(speed)
	tween.interpolate_property(
		self, 
		"follow", 
		move_from, 
		move_to, 
		duration, 
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT,
		idle_duration
	)
	tween.interpolate_property(
		self, 
		"follow", 
		move_to, 
		move_from, 
		duration, 
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT,
		idle_duration*2+duration
	)
	tween.start()