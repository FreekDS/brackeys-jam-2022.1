extends KinematicBody2D

export var speed = 500
export var jump_strength = 350
export var GRAVITY = 981

var velocity = Vector2.ZERO

onready var light = $LightJoint

func get_input():
	var dir = 0
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		dir = -1
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		dir = 1
	return dir

func _physics_process(delta):
	var dir = get_input()
	velocity.x = dir * speed
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_strength
	light.look_at(get_global_mouse_position())


