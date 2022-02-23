extends Interactable


var current_message = 0

var messages = [
	"It looks like paint",
	"But is it paint?",
	"Ah no, it is medicine",
	"Only on doctors presciption it says",
	"I better not take those..."
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
			emit_signal("action_message", round_robin_message())


func _on_gameState_change(_level, state):
	if state in [StateManager.GARAGE.PICKED_UP_PHONE]:
		enabled = true
