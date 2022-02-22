extends Interactable


func interact():
	if can_be_clicked:
		emit_signal("action_message", "Ah, daar is mijn boormachien!")
