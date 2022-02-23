extends Interactable

export var offset = -300

var messages_0 = [
	"This is Willi's favourite food",
	"And best is, it is only €3.99!",
	"Not to be cheap or something...",
	"He really likes it",
	"I hope...",
	"Anyway..."
]

var messages_1 = [
	"I wonder what it tastes like",
	
]

var messages_2 = [
	"The eyes on this bag...\nThey stare right into my soul",
	"What is it made of?"
]

var messages_3 = [
	"Are you it?",
	"I am watching you, \nyou piece of bag!",
	"Do I even have a cat?",
	"Did it... move?"
]


func round_robin_message(messages):
	current_message = current_message % len(messages)
	var msg = messages[current_message]
	current_message += 1
	return msg


func interact():
	if not enabled or not can_be_clicked:
		return
	
	match StateManager.current_state:
		StateManager.GARAGE.PICKED_UP_PHONE:
			emit_signal("action_message", round_robin_message(messages_0), offset)
		_:
			match StateManager.insanity_level:
				StateManager.INSANITY.CANNOT_HURT:
					emit_signal("action_message", round_robin_message(messages_1), offset)
					pass
				StateManager.INSANITY.MIGHT_HURT:
					emit_signal("action_message", round_robin_message(messages_2), offset)
					pass
				StateManager.INSANITY.WILL_HURT:
					emit_signal("action_message", round_robin_message(messages_3), offset)
					pass
				StateManager.INSANITY.HURT:
					# not required, level end
					pass


func _on_gameState_change(_level, state):
	if state in [StateManager.GARAGE.PICKED_UP_PHONE]:
		enabled = true
