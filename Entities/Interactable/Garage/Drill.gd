extends Interactable

export(int) var text_offset = 0


var messages = [
	"Oh here is the drill I lost",
	"The batteries died though...",
	"I once made a house for my cat with this!"
]



func interact():
	if not enabled or not can_be_clicked:
		return
	
	if can_be_clicked:
		
		if StateManager.current_state == StateManager.GARAGE.PHONE_DIALED:
			if StateManager.state_meta.has('items') and StateManager.state_meta['items'].has('batteries'):
				StateManager.state_meta['items'].append('drill')
				emit_signal("action_message", "That will do")
				visible = false
				yield(get_tree().create_timer(2.0), "timeout")
				StateManager.change_state(StateManager.GARAGE.DRILL_ACQUIRED)
				enabled = false
				call_deferred("queue_free")
			else:
				emit_signal("action_message", "There should be batteries somewhere...")
		else:
			emit_signal("action_message", round_robin_message(messages), text_offset)


func _on_gameState_change(_level, state):
	if state in [StateManager.GARAGE.PICKED_UP_PHONE]:
		enabled = true
