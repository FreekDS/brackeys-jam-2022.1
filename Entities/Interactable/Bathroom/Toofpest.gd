extends Interactable


func _ready():
	enable_on = [
		StateManager.BATHROOM.TOWELS_DEPOSITED
	]


func interact():
	if not enabled or not can_be_clicked:
		return
		
	emit_signal("action_message", "I can use this to brush my teeth")
	visible = false
	StateManager.change_state(StateManager.BATHROOM.TOOTHPASTE_TAKEN)
	call_deferred("queue_free")
	complete()

