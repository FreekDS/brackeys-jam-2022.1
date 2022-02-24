extends Interactable

export var offset = -115

var messages_0 = [
	"It is just a fuse box\nIt has no feelings",
]

var messages_1 = [
	"It is just a fuse box\nIt has no feelings",
	"Or has it?"
]


func interact():
	if not enabled or not can_be_clicked:
		return
	
	match StateManager.current_state:
		StateManager.GARAGE.CLOSET_DRILLED:
			if StateManager.state_meta.has('items') and StateManager.state_meta['items'].has('crowbar'):
				# TODO: doe break animatie ofzo
				emit_signal("action_message", "Take this!")
				yield(get_tree().create_timer(3), "timeout")
				StateManager.insanity_level = StateManager.INSANITY.HURT
				emit_signal("action_insanity", "IT HURTS")
				yield(get_tree().create_timer(3), "timeout")
				StateManager.change_state(StateManager.GARAGE.END)
		_:
			match StateManager.insanity_level:
				StateManager.INSANITY.CANNOT_HURT:
					emit_signal("action_message", round_robin_message(messages_0), offset)
					pass
				StateManager.INSANITY.MIGHT_HURT:
					emit_signal("action_message", round_robin_message(messages_1), offset)
					pass
				StateManager.INSANITY.WILL_HURT:
					# Not applicable
					pass
				StateManager.INSANITY.HURT:
					# Not applicable
					pass
	complete()


func _on_gameState_change(_level, state):
	if state in [StateManager.GARAGE.PICKED_UP_PHONE]:
		enable()
