extends Interactable

var messages = {
	0: [""],
	1: [""],
	2: [""]
}

func interact():
	if not enabled or not can_be_clicked:
		return
		
	match StateManager.current_state:
		StateManager.LIVING.FISH_WATERED:
			visible = false
			emit_signal("action_message", "Food for the fish")
			yield(get_tree().create_timer(3), "timeout")
			StateManager.change_state(StateManager.LIVING.FOOD_TAKEN)
			call_deferred("queue_free")
		_: # default
			emit_signal("action_message", round_robin_message(messages[StateManager.insanity_level]))
			pass
	
	complete()

func _on_gameState_change(_level, state):
	if state == StateManager.LIVING.FISH_WATERED:
		enable()

