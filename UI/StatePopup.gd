tool
extends Control

onready var label = $Container/RichTextLabel
export var text = "it is not real, it cannot hurt you" setget set_text

func set_text(t):
	text = t
	if label:
		label.bbcode_text = "[center]" + text + "[/center]"
	update()
	

func trigger(new_text = null):
	if new_text:
		set_text(new_text)
	visible = true
	yield(get_tree().create_timer(3), "timeout")
	visible = false






