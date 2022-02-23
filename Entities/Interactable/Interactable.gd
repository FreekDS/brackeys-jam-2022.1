tool
extends Node2D
class_name Interactable

onready var animations = $AnimationPlayer

# TODO: possibility to offset text (avoid falloff of screen)

# warning-ignore:unused_signal
signal action_message(string, offset)
# warning-ignore:unused_signal
signal action_telephone(state)
# warning-ignore:unused_signal
signal on_interact(with)
# warning-ignore:unused_signal
signal action_insanity(text)



var can_be_clicked = false
var mouse_in = false
var detected = false

export var debug_draw = true setget set_debug
export var detection_radius = 200 setget set_radius

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
	if detected:
		play_anim()
	mouse_in = true


func _on_mouse_exit():
	if mouse_in and detected:
		play_anim(true)
	mouse_in = false

func play_anim(back = false):
	if back:
		animations.play_backwards("mouse enter")
	else:
		animations.play("mouse enter")
	can_be_clicked = not back

func check_in_range(source_pos: Vector2):
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
	if can_be_clicked:
		emit_signal("on_interact", self.name)
