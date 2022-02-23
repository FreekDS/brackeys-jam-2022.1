extends Interactable

var messages_0 = [
	""
]

var messages_1 = [
	""
]

var messages_2 = [
	""
]

func interact():
	if not enabled or not can_be_clicked:
		return
	
	emit_signal("action_message", "I used to play a lot of ping pong with my brother")


func _on_gameState_change(_level, state):
	if state in [StateManager.GARAGE.PICKED_UP_PHONE]:
		enabled = true

