extends Interactable


func interact():
	if not enabled or not can_be_clicked:
		return
		
	match StateManager.current_state:
		StateManager.LIVING.BOX_INTERACTED:
			emit_signal("action_message", "Pling plong")
		_: # default
			pass
	complete()

func _on_gameState_change(_level, state):
	if state == StateManager.LIVING.BOX_INTERACTED:
		enable()
