extends Interactable

export(int) var text_offset = 0

func interact():
	if can_be_clicked:
		emit_signal("action_message", "Ah, daar is mijn boormachien!", text_offset)
