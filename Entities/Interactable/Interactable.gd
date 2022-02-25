tool
extends Node2D
class_name Interactable

onready var animations = $AnimationPlayer


# warning-ignore:unused_signal
signal action_message(string, offset)
# warning-ignore:unused_signal
signal action_telephone(state)
# warning-ignore:unused_signal
signal on_interact(with)
# warning-ignore:unused_signal
signal action_end_level()
# warning-ignore:unused_signal
signal action_insanity(text)
signal resume

var enabled = false
var prev_enabled = false
var is_paused = false

var can_be_clicked = false
var mouse_in = false
var mouse_was_in = false
var detected = false

export var debug_draw = true setget set_debug
export var detection_radius = 200 setget set_radius

var current_message = 0
func round_robin_message(messages):
	current_message = current_message % len(messages)
	var msg = messages[current_message]
	current_message += 1
	return msg
	

func send_round_robin(messages, offset=0):
	if StateManager.insanity_level > 2:
		return
	var msg = round_robin_message(messages[StateManager.insanity_level])
	if msg and msg != "":
		specific_message(msg, offset)
	
func specific_message(msg, offset=0):
	emit_signal("action_message", msg, offset)

func set_radius(value):
	detection_radius = value
	update()
	
func set_debug(value):
	debug_draw = value
	update()

func _ready():
	if not Engine.editor_hint:
		$Area2D.visible = true
	else:
		$Area2D.visible = false


func _on_mouse_over():

	if detected and enabled:
		play_anim()
	mouse_in = true


func _on_mouse_exit(update=true):	
	if mouse_in and detected:
		play_anim(true)
	if update:
		mouse_in = false

func play_anim(back = false):
	if back:
		animations.play_backwards("mouse enter")
	else:
		animations.play("mouse enter")
	can_be_clicked = not back

func check_in_range(source_pos: Vector2):
	
	if not enabled:
		return
	
	var dist = source_pos.distance_to(self.global_position)
	detected = dist <= detection_radius
	if not detected and can_be_clicked:
		play_anim(true)
	if detected and mouse_in and not can_be_clicked:
		play_anim()
		
		
func _draw():
	if Engine.editor_hint and debug_draw:
		var radius = detection_radius / self.scale.x
		draw_circle(Vector2.ZERO, radius, Color(1,1,1,0.5))

func interact():
	
	if not enabled:
		return
	
	if can_be_clicked:
		emit_signal("on_interact", self.name)

func complete():
	emit_signal("resume")

func _on_gameState_change(_level, _state):
	pass


func enable():
	enabled = true
	prev_enabled = true
	
func disable():
	enabled = false
	prev_enabled = false


func pause():
	if not is_paused:
		prev_enabled = enabled
		enabled = false
		is_paused = true
		mouse_was_in = mouse_in
		_on_mouse_exit(false)

func unpause():
	if is_paused:
		enabled = prev_enabled
		is_paused = false
		if enabled and mouse_was_in and mouse_in:
			mouse_was_in = false
			play_anim()
			
func _process(delta):
#	print(StateManager.current_state)
	pass

