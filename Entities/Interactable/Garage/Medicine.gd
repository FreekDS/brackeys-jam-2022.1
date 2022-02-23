extends Interactable


var messages = [
	"It looks like paint",
	"But is it paint?",
	"Ah no, it is medicine",
	"Only on doctors presciption it says",
	"I better not take those..."
]


func interact():
	if not enabled or not can_be_clicked:
		return
	
	match StateManager.current_state:
		StateManager.GARAGE.PICKED_UP_PHONE:
			emit_signal("action_message", round_robin_message(messages))
	complete()


func _on_gameState_change(_level, state):
	if state in [StateManager.GARAGE.PICKED_UP_PHONE]:
		enable()
