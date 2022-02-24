extends Interactable

var messages = [
	"Mom said: there is a time and place for everything, \nbut not now!"
]


func interact():
	if can_be_clicked and enabled:
		specific_message(messages[0])
		complete()

func _on_gameState_change(_level, state):
	current_message = 0
	if state in [StateManager.GARAGE.PICKED_UP_PHONE]:
		enable()
