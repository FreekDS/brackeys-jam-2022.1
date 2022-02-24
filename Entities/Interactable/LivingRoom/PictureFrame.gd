extends Interactable


var messages = {
	0: ["It is a picture", "It is taken at the collosseum", "I can't remember in which country"],
	1: [""],
	2: [""]
}


func interact():
	if not enabled or not can_be_clicked:
		return
		
	match StateManager.current_state:
		StateManager.LIVING.BOX_INTERACTED:
			emit_signal("action_message", round_robin_message(messages[0]))
		_: # default
			emit_signal("action_message", round_robin_message(messages[StateManager.insanity_level]))
			pass
	complete()

func _on_gameState_change(_level, state):
	if state == StateManager.LIVING.BOX_INTERACTED:
		enable()
