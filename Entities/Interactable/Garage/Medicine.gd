extends Interactable

var messages = {
	0: [
		"It looks like paint",
		"But is it paint?",
		"Ah no, it is medicine",
		"Only on doctors presciption it says",
		"I better not take those..."
	],
	1: [],
	2: []
}


func interact():
	if not enabled or not can_be_clicked:
		return
	
	match StateManager.current_state:
		StateManager.GARAGE.PICKED_UP_PHONE:
			send_round_robin(messages)
			yield(get_tree().create_timer(1), "timeout")
	complete()


func _on_gameState_change(_level, state):
	current_message = 0
	if state in [StateManager.GARAGE.PICKED_UP_PHONE]:
		enable()
