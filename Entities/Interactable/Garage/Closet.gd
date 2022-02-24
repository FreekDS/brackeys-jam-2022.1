extends Interactable

var keep_disabled = false

var messages = {
	0: ["It is locked"],
	1: ["It is locked"],
	2: ["It is locked"]
}

func interact():
	if not enabled or not can_be_clicked:
		return
	
	match StateManager.current_state:
		StateManager.GARAGE.DRILL_ACQUIRED:
			specific_message("let me drill this closet open, quickly!")
			yield(get_tree().create_timer(3), "timeout")
#			_on_mouse_exit()
			disable()
			keep_disabled = true
			StateManager.change_state(StateManager.GARAGE.CLOSET_DRILLED)
		_:
			send_round_robin(messages)
	
	complete()


func _on_gameState_change(_level, state):
	current_message = 0
	if state in [StateManager.GARAGE.PICKED_UP_PHONE]:
		enable()
	if keep_disabled:
		disable()



