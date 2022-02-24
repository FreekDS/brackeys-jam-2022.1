extends Interactable


var messages_0 = [
	"It is a used car tire"
]

var messages_1 = [
	"Yep, that tire is still used"
]

var messages_2 = [
	"No changes here, it is a used tire",
	"The tire has been used already",
	"The tire is unused (just kidding, it is)",
	"Why would you keep a used tire anyway?"
]


func interact():
	if not enabled or not can_be_clicked:
		return
	
	match StateManager.insanity_level:
		StateManager.INSANITY.CANNOT_HURT:
			emit_signal("action_message", round_robin_message(messages_0))
		StateManager.INSANITY.MIGHT_HURT:
			emit_signal("action_message", round_robin_message(messages_1))
		StateManager.INSANITY.WILL_HURT:
			emit_signal("action_message", round_robin_message(messages_2))
	
	complete()

func _on_gameState_change(_level, state):
	if state in [StateManager.GARAGE.PICKED_UP_PHONE]:
		enable()
