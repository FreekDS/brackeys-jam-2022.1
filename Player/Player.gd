extends KinematicBody2D

export var speed = 200

var direction = Vector2.ZERO
var velocity = Vector2.ZERO

onready var light = $LightJoint

func get_input_vec():
	var dir = Vector2.ZERO
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		dir.x = -1
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		dir.x = 1
	if Input.is_action_pressed("down") and not Input.is_action_pressed("up"):
		dir.y = 1
	elif Input.is_action_pressed("up") and not Input.is_action_pressed("down"):
		dir.y = -1
	return dir


func _ready():
	pass
	

func _physics_process(_delta):
	direction = get_input_vec()
	velocity = move_and_slide(direction.normalized() * speed)
	light.look_at(get_global_mouse_position())


