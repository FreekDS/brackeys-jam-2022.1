extends KinematicBody2D

export var speed = 500
export var jump_strength = 600
export var GRAVITY = 3000
#export var GRAVITY = 0

var velocity = Vector2.ZERO

onready var text = $CanvasLayer/Text
onready var textPos = $TextPosition
onready var light = $LightJoint

signal interact

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
	velocity = move_and_slide_with_snap(velocity, Vector2.ZERO, Vector2.UP)
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_strength
	light.look_at(get_global_mouse_position())
	
func _ready():
	text.visible = false
	

func say_something(message):
	text.set_content(message)
	text.set_position(textPos.get_global_transform_with_canvas().origin)
	text.play_text()

	
func _unhandled_input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		if event.is_action_pressed("interact"):
			emit_signal("interact")

		elif event.has_meta("scancode") and event.scancode == KEY_X:
			var dinges = [
				"Wtf is dees",
				"hahahahahahha",
				"Wanneer pannekeoekenslag?",
				"Mag ik ne cola?",
				"NEE GENE COLA GEVEN",
				"Vrijdag is het feest",
				"Ist nog ver",
				"Mijn voeten doen zeer",
				"Ik moet naar toilet",
				"Wie heeft da godot logo hier geplakt gvd",
				"Gij se lelek foorwijf",
				"Wa een mottige deur",
				"KESSE KESSE KESSE",
				"Jaja, tzijn toeren",
				"BOGOS BINTED?"
			]
			var item = dinges[randi() % dinges.size()]
			text.visible = true
			text.set_position(
				textPos.get_global_transform_with_canvas().origin
			)
			text.percent_visible = 0
			text.set_content(item)
			text.play_text()
			return


