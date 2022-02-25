extends Interactable


func _ready():
	enable_on = [
		StateManager.BATHROOM.SHOWER_OPENED
	]

func interact():
	if not enabled or not can_be_clicked:
		return
		
	emit_signal("action_message", "I can wash me with this")
	visible = false
	StateManager.change_state(StateManager.BATHROOM.SOAP_TAKEN)
	call_deferred("queue_free")
	complete()
	
func _on_gameState_change(level, state):
	._on_gameState_change(level, state)
	if state in enable_on:
		visible = true
