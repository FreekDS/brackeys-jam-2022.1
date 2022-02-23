tool
extends Control

onready var label = $Container/RichTextLabel
onready var glitch = $ScreenGlitch

export var text = "it is not real, it cannot hurt you" setget set_text

signal finished

func set_text(t):
	text = t
	if label:
		label.bbcode_text = "[center]" + text + "[/center]"
	update()
	

func trigger(new_text = null):
	if new_text:
		set_text(new_text)
	
	glitch.visible = true
	match StateManager.insanity_level:
		StateManager.INSANITY.CANNOT_HURT:
			glitch.visible = false
		StateManager.INSANITY.MIGHT_HURT:
			glitch.material.set_shader_param("strength", 12)
		StateManager.INSANITY.WILL_HURT:
			glitch.material.set_shader_param("strength", 16)
		StateManager.INSANITY.HURT:
			glitch.material.set_shader_param("strength", 20)
	
	visible = true
	yield(get_tree().create_timer(3), "timeout")
	visible = false
	emit_signal("finished")






