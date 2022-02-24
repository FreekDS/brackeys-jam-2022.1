extends Interactable

var messages = {
	0: ["I used to play a lot of ping pong with my brother"],
	1: ["I used to play a lot of ping pong with my brother"],
	2: ["I used to play a lot of ping pong with my brother"],
}


func interact():
	if not enabled or not can_be_clicked:
		return
	send_round_robin(messages)
	yield(get_tree().create_timer(1), "timeout")
	complete()


func _on_gameState_change(_level, state):
	current_message = 0
	if state in [StateManager.GARAGE.PICKED_UP_PHONE]:
		enable()

