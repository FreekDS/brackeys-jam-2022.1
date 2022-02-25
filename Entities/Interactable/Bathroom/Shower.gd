extends Interactable


onready var ShowerAnimations = $ShowerAnimations

var opened = false


# Called when the node enters the scene tree for the first time.
func _ready():
	enable_on = [
		StateManager.BATHROOM.INIT
	]

func interact():
	if not enabled or not can_be_clicked:
		return
	
	if not opened:
		ShowerAnimations.play("Open")
		opened = true
	else:
		ShowerAnimations.play_backwards("Open")
		opened = false
	
	
	complete()
