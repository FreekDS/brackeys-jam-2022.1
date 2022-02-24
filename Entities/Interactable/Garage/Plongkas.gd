extends Interactable

export var offset = -115

var messages = {
	0: ["It is just a fuse box\nIt has no feelings",],
	1: [
		"It is just a fuse box\nIt has no feelings",
		"Or has it?"
	],
	2: []
}



func interact():
	if not enabled or not can_be_clicked:
		return
	
	match StateManager.current_state:
		StateManager.GARAGE.CLOSET_DRILLED:
			if StateManager.state_meta.has('items') and StateManager.state_meta['items'].has('crowbar'):
				# TODO: doe break animatie ofzo
				specific_message("Take this!")
				yield(get_tree().create_timer(3), "timeout")
				StateManager.insanity_level = StateManager.INSANITY.HURT
				emit_signal("action_insanity", "IT HURTS")
				yield(get_tree().create_timer(3), "timeout")
				StateManager.change_state(StateManager.GARAGE.END)
		_:
			send_round_robin(messages, offset)
			yield(get_tree().create_timer(1), "timeout")
			

	complete()


func _on_gameState_change(_level, state):
	current_message = 0
	if state in [StateManager.GARAGE.PICKED_UP_PHONE]:
		enable()
