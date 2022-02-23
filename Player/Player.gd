extends KinematicBody2D

export var speed = 500
export var jump_strength = 600
export var GRAVITY = 3000
#export var GRAVITY = 0

var velocity = Vector2.ZERO

onready var text = $CanvasLayer/Text
onready var textPos = $TextPosition
onready var BodySprites = $BodySprite
onready var HeadSprites = $NeckJoint/HeadSprite
onready var PlayerAnimations = $AnimationTree
onready var Neck = $NeckJoint


signal interact

func get_input():
	var dir = 0
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		dir = -1
		BodySprites.flip_h = true
		HeadSprites.flip_h = true
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		dir = 1
		BodySprites.flip_h = false
		HeadSprites.flip_h = false
	return dir
	

func is_facing_left():
	return BodySprites.flip_h


func _physics_process(delta):
	var dir = get_input()
	velocity.x = dir * speed
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_strength
	
	
	# Neck rotation (blijkt dat ik ni kan nadenken :'()
	var mouse_position = get_global_mouse_position()
	var angle = rad2deg(Neck.global_position.angle_to_point(mouse_position))
	
	if is_facing_left():
		if global_position.x > mouse_position.x:
			Neck.rotation_degrees = clamp(angle, -20, 20)
		else:
			Neck.rotation_degrees = 0
	else:
		if global_position.x < mouse_position.x:
			Neck.look_at(mouse_position)
			Neck.rotation_degrees = clamp(Neck.rotation_degrees, -20, 20)
		else:
			Neck.rotation_degrees = 0
			

#	var look_direction = get_global_mouse_position()
#	if is_facing_left():
#		var x_distance = look_direction.x - Neck.global_position.x
#		look_direction.x -= x_distance
#
#	Neck.look_at(get_global_mouse_position())
#	var rotation_max = 20
#	Neck.rotation_degrees = clamp(Neck.rotation_degrees, -rotation_max, rotation_max)

	
	# Animations
	if velocity != Vector2.ZERO:
		PlayerAnimations["parameters/moving/blend_amount"] = 1.0
	else:
		PlayerAnimations["parameters/moving/blend_amount"] = 0
	
func _ready():
	text.visible = false
	PlayerAnimations.active = true


func say_something(message, offset=0):
	text.set_content(message)
	text.set_global_position(textPos.global_position + Vector2(offset, 0))
	text.play_text()

	
func _unhandled_input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		if event.is_action_pressed("interact"):
			emit_signal("interact")
