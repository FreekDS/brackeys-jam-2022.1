extends Interactable

export var offset = -115

var texts = {
	StateManager.GARAGE.PICKED_UP_PHONE: "It is just a fuse box\nIt has no feelings"
}


func interact():
	if not enabled or not can_be_clicked:
		return
	
	match StateManager.current_state:
		StateManager.GARAGE.PICKED_UP_PHONE:
			emit_signal("action_message", texts[StateManager.current_state], offset)
		StateManager.GARAGE.CLOSET_DRILLED:
			if StateManager.state_meta.has('items') and StateManager.state_meta['items'].has('crowbar'):
				# TODO: doe break animatie ofzo
				emit_signal("action_message", "Take this!")
				yield(get_tree().create_timer(3), "timeout")
				StateManager.insanity_level = StateManager.INSANITY.HURT
				emit_signal("action_insanity", "IT HURTS")
				yield(get_tree().create_timer(3), "timeout")
				StateManager.change_state(StateManager.GARAGE.END)
				


func _on_gameState_change(_level, state):
	if state in [StateManager.GARAGE.PICKED_UP_PHONE]:
		enabled = true
