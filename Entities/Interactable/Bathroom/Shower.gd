extends Interactable


onready var ShowerAnimations = $ShowerAnimations

var opened = false


# Called when the node enters the scene tree for the first time.
func _ready():
	enable_on = [
		StateManager.BATHROOM.TEETH_BRUSHED,
		StateManager.BATHROOM.SOAP_TAKEN
	]
	disable_on = [
		StateManager.BATHROOM.SHOWER_OPENED
	]

func interact():
	if not enabled or not can_be_clicked:
		return
	
	if not opened:
		ShowerAnimations.play("Open")
		StateManager.change_state(StateManager.BATHROOM.SHOWER_OPENED)
		opened = true
	else:
		ShowerAnimations.play_backwards("Open")
		opened = false
	
	
	complete()
