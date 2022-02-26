tool
extends CanvasLayer


export var is_visible = false setget set_visible


func set_visible(value):
	is_visible = value
	if Root:
		Root.visible = value


onready var Root = $Root

func _ready():
	Root.visible = false

func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().paused = true
		Root.visible = true


func _on_Exit_pressed():
	get_tree().quit()


func _on_Resume_pressed():
	Root.visible = false
	get_tree().paused = false
