extends Interactable

var messages = [
	"Mom said: there is time and place for everything, but not now!"
]


func interact():
	if can_be_clicked:
		emit_signal("action_message", messages[0])
