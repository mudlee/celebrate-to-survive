extends KinematicBody2D

signal fireworks_active
signal fireworks_not_active
onready var fireworks = get_node("Fireworks")
onready var fireworks_shards = get_node("Fireworks/Shards")

const FIREWORKS_PAUSE_LENGTH = 2.0
const ACCELERATION = 10000.0
const MAX_SPEED = 6000
const GRAVITY = 12000.0
const JUMP_FORCE = 14000.0

var velocity = Vector2()
var direction = 0
var input_direction = 0
var speed_x = 0
var speed_y = 0
var jumping = false
var fireworks_activated_time
var fireworks_active = false

func _ready():
	for platform in get_parent().get_node("Platforms").get_children():
		connect("fireworks_active", platform, "fireworks_active")
		connect("fireworks_not_active", platform, "fireworks_not_active")


func _input(event):
	if event.is_action_pressed("jump") and is_on_floor():
		speed_y = -JUMP_FORCE
		jumping = true

	if not fireworks_active and event.is_action_pressed("fireworks"):
		fireworks.emitting = true
		fireworks_shards.emitting = true
		fireworks_activated_time = OS.get_ticks_msec()
		fireworks_active = true
		emit_signal("fireworks_active")


func _process(delta):
	if fireworks_active && float((OS.get_ticks_msec() - fireworks_activated_time))/1000.0 > FIREWORKS_PAUSE_LENGTH:
		fireworks_active = false
		emit_signal("fireworks_not_active")

	
func _physics_process(delta):
	handle_movement(delta)

func handle_movement(delta):
	if input_direction:
		direction = input_direction

	if Input.is_action_pressed('right'):
		input_direction = 1
	elif Input.is_action_pressed('left'):
		input_direction = -1
	else:
		input_direction = 0

	if input_direction == -direction:
		speed_x /= 3
	if input_direction:
		speed_x += ACCELERATION * delta
	else:
		speed_x -= ACCELERATION * delta
	
	speed_x = clamp(speed_x, 0, MAX_SPEED)
	speed_y += GRAVITY * delta

	velocity.x = speed_x * delta * direction
	velocity.y = speed_y * delta
	move_and_slide(velocity, Vector2(0,-1))

	if jumping and is_on_floor():
		jumping=false