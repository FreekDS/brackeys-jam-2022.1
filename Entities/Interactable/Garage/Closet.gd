extends Interactable

var keep_disabled = false

func interact():
	if not enabled or not can_be_clicked:
		return
	
	match StateManager.current_state:
		StateManager.GARAGE.DRILL_ACQUIRED:
			emit_signal("action_message", "let me drill this closet open, quickly!")
			yield(get_tree().create_timer(3), "timeout")
			_on_mouse_exit()
			enabled = false
			keep_disabled = true
			StateManager.change_state(StateManager.GARAGE.CLOSET_DRILLED)
		_:
			emit_signal("action_message", "It is locked")


func _on_gameState_change(_level, state):
	if state in [StateManager.GARAGE.PICKED_UP_PHONE]:
		enabled = true
	if keep_disabled:
		enabled = false



