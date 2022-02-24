extends Interactable

var messages = [
	"It is a picture",
	"It is taken at the colosseum",
	"I can't remember in which country"
]


func interact():
	if not enabled or not can_be_clicked:
		return
		
	match StateManager.current_state:
		StateManager.LIVING.BOX_INTERACTED:
			emit_signal("action_message", round_robin_message(messages))
		_: # default
			pass
	complete()

func _on_gameState_change(_level, state):
	if state == StateManager.LIVING.BOX_INTERACTED:
		enable()
