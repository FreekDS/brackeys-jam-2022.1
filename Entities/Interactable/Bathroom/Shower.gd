extends Interactable


onready var ShowerAnimations = $ShowerAnimations
onready var MouseArea = $Area2D/CollisionPolygon2D

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
	
	emit_signal("on_interact", self.name)
	$AudioStreamPlayer2D.playing = true
	if not opened:
		ShowerAnimations.play("Open")
		opened = true
	else:
		ShowerAnimations.play_backwards("Open")
		opened = false
	
	match StateManager.current_state:
		StateManager.BATHROOM.TEETH_BRUSHED:
			StateManager.change_state(StateManager.BATHROOM.SHOWER_OPENED)
	
	complete()
	
func _on_gameState_change(level, state):
	._on_gameState_change(level, state)
	if state == StateManager.BATHROOM.SHOWER_OPENED:
		MouseArea.disabled = true
	elif state in enable_on:
		MouseArea.disabled = false
	
