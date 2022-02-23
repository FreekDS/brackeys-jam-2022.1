extends Interactable

export var offset = -300

var current_message = 0

var messages = [
	"This is Willi's favourite food",
	"And best is, it is only €3.99!",
	"Not to be cheap or something...",
	"He really likes it",
	"I hope...",
	"Anyway..."
]


func round_robin_message():
	var msg = messages[current_message]
	current_message += 1
	current_message = current_message % len(messages)
	return msg


func interact():
	if not enabled or not can_be_clicked:
		return
	
	match StateManager.current_state:
		StateManager.GARAGE.PICKED_UP_PHONE:
			emit_signal("action_message", round_robin_message(), offset)


func _on_gameState_change(_level, state):
	if state in [StateManager.GARAGE.PICKED_UP_PHONE]:
		enabled = true
