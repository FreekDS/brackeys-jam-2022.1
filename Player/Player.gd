extends KinematicBody2D

export var speed = 500
export var jump_strength = 600
export var GRAVITY = 3000
#export var GRAVITY = 0

var velocity = Vector2.ZERO
export var in_cutscene = false
export var disable_movement = false
export var neck_rotation = 0 setget set_neck_rotation

onready var text = $CanvasLayer/Text
onready var textPos = $TextPosition
onready var BodySprites = $BodySprite
onready var HeadSprites = $NeckJoint/HeadSprite
onready var PlayerAnimations = $AnimationTree
onready var Neck = $NeckJoint


signal interact

func flip(value):
	BodySprites.flip_h = value
	HeadSprites.flip_h = value
	
func set_neck_rotation(rotation_deg):
	if Neck:
		Neck.rotation_degrees = rotation_deg
	

func get_input():
	if disable_movement:
		return 0
	var dir = 0
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		dir = -1
		flip(true)
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		dir = 1
		flip(false)
	return dir
	

func is_facing_left():
	return BodySprites.flip_h


func _physics_process(delta):
	if in_cutscene:
		return
	var dir = get_input()
	velocity.x = dir * speed
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_pressed("jump"):
		if is_on_floor() and not disable_movement:
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
	
	if disable_movement:
		Neck.rotation_degrees = 0
	
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


func _on_InsanityStateDisplay_playing(fear=true):
	disable_movement = true
	if fear:
		PlayerAnimations["parameters/fear/blend_amount"] = 1.0


func _on_InsanityStateDisplay_finished():
	disable_movement = false
	PlayerAnimations["parameters/fear/blend_amount"] = 0.0

