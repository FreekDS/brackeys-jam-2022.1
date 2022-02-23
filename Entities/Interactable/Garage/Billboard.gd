tool
extends Interactable





func interact():
	if not enabled or not can_be_clicked:
		return
	
	match StateManager.current_state:
		StateManager.GARAGE.DIARY_OPENED:
			if StateManager.state_meta.has('items'):
				if StateManager.state_meta['items'].has('phone_number'):
					return
			emit_signal("action_message", "There is a note on the billboard\nWritten in my own handwriting:")
			yield(get_tree().create_timer(4), "timeout")
			emit_signal("action_message", "*If you can read this, dial 0069021210420*")
			if not StateManager.state_meta.has('items'):
				StateManager.state_meta['items'] = []
			StateManager.state_meta['items'].append('phone_number')
			enabled = false


func _on_gameState_change(_level, state):
	if state in [StateManager.GARAGE.DIARY_OPENED]:
		enabled = true
