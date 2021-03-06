extends Interactable

var messages = {
	0: ["Pizza time"],
	1: ["Pizza time"],
	2: ["Pizza time"]
}

func interact():
	if not enabled or not can_be_clicked:
		return
		
	match StateManager.current_state:
		StateManager.LIVING.TV_INTERACTED:
			emit_signal("action_message", "Oh a leftover slice!\n*eats it*")
			$AudioStreamPlayer2D.playing = true
			yield(get_tree().create_timer(3), "timeout")
			emit_signal("action_message", "Now im thirsty...")
			StateManager.change_state(StateManager.LIVING.THIRSTY)
			pass
		_: # default
			emit_signal("action_message", round_robin_message(messages[StateManager.insanity_level]))
			pass
	
	complete()

func _on_gameState_change(_level, state):
	if state == StateManager.LIVING.TV_INTERACTED:
		enable()
