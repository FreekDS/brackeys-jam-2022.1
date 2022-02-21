tool
extends Control

onready var label = $Container/RichTextLabel
export var text = "it is not real, it cannot hurt you" setget set_text

func set_text(t):
	text = t
	if label:
		label.bbcode_text = "[center]" + text + "[/center]"
	update()





