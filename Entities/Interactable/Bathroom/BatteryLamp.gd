tool
extends Interactable


onready var modulateColor = Color(5, 5, 1)
onready var MySprite = $Sprite

var on = false


func _ready():
	enable_on = [
		StateManager.BATHROOM.INIT
	]
	modulate = Color.white


func interact():
	if not can_be_clicked or not enabled:
		return
	
	$AudioStreamPlayer2D.playing = true
	if on:
		modulate = Color.white
		on = false
	else:
		modulate = modulateColor
		on = true
	
	complete()

