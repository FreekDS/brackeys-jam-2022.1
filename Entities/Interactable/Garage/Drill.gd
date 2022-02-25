extends Interactable

export(int) var text_offset = 0

var messages = {
	0: [
		"Oh here is the drill I lost",
		"The batteries died though...",
		"I once made a house for my cat with this!"
	],
	1: [
		"Oh here is the drill I lost",
		"The batteries died though...",
		"I once made a house for my cat with this!"
	],
	2: [
		"Oh here is the drill I lost",
		"The batteries died though...",
		"I once made a house for my cat with this!"
	]
}

func _ready():
	enable_on = [
		StateManager.GARAGE.PICKED_UP_PHONE
	]
	disable_on = []

func interact():
	if not enabled or not can_be_clicked:
		return
	
	if can_be_clicked:
		if StateManager.current_state == StateManager.GARAGE.PHONE_DIALED:
			if StateManager.state_meta.has('items') and StateManager.state_meta['items'].has('batteries'):
				StateManager.state_meta['items'].append('drill')
				specific_message("That will do")
				visible = false
				yield(get_tree().create_timer(2.0), "timeout")
				StateManager.change_state(StateManager.GARAGE.DRILL_ACQUIRED)
				enabled = false
				call_deferred("queue_free")
			else:
				specific_message("There should be batteries somewhere...")
		else:
			send_round_robin(messages, text_offset)
	
	complete()
