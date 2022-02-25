extends Interactable

export var offset = -300

var messages = {
	0: [
		"This is Willi's favourite food",
		"And best is, it is only €3.99!",
		"Not to be cheap or something...",
		"He really likes it",
		"I hope...",
		"Anyway..."
	],
	1: [
		"I wonder what it tastes like",
		"The eyes on this bag...\nThey stare right into my soul",
		"What is it made of?"
	],
	2: [
		"Are you it?",
		"I am watching you, \nyou piece of bag!",
		"Do I even have a cat?",
		"Did it... move?"
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
	send_round_robin(messages, offset)
	yield(get_tree().create_timer(1), "timeout")
	complete()
