extends Interactable


var messages = {
	0: ["It is a picture", "It is taken at the collosseum", "I can't remember in which country"],
	1: ["It is a picture", "It is taken at the collosseum", "I can't remember in which country"],
	2: ["It is a picture", "It is taken at the collosseum", "I can't remember in which country"]
}


func interact():
	if not enabled or not can_be_clicked:
		return
		
	send_round_robin(messages)
	complete()

func _on_gameState_change(_level, state):
	if state == StateManager.LIVING.BOX_INTERACTED:
		enable()
