extends Interactable

func interact():
	if not enabled or not can_be_clicked:
		return
		
	match StateManager.current_state:
		StateManager.LIVING.THIRSTY:
			emit_signal("action_message", "Water will help\n*gulp*")
			visible = false
			yield(get_tree().create_timer(3), "timeout")
			emit_signal("action_message", "The plant looks thirsty")
			yield(get_tree().create_timer(3), "timeout")
			StateManager.change_state(StateManager.LIVING.BOTTLE_TAKEN)
			complete()
			call_deferred("queue_free")
		_: # default
			pass

func _on_gameState_change(_level, state):
	if state == StateManager.LIVING.THIRSTY:
		enable()
