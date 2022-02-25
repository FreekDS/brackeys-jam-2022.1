extends Interactable

var messages = {
	0: ["I used to play a lot of ping pong with my brother"],
	1: ["I used to play a lot of ping pong with my brother"],
	2: ["I used to play a lot of ping pong with my brother"],
}

func _ready():
	enable_on = [
		StateManager.GARAGE.PICKED_UP_PHONE
	]

func interact():
	if not enabled or not can_be_clicked:
		return
	send_round_robin(messages)
	yield(get_tree().create_timer(1), "timeout")
	complete()
