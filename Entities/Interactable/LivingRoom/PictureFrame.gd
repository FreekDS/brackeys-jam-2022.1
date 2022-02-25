extends Interactable


var messages = {
	0: ["It is a picture", "It is taken at the collosseum", "I can't remember in which country"],
	1: ["It is a picture", "It is taken at the collosseum", "I can't remember in which country"],
	2: ["It is a picture", "It is taken at the collosseum", "I can't remember in which country"]
}

func _ready():
	enable_on = [
		StateManager.LIVING.BOX_INTERACTED
	]
	disable_on = [
		
	]


func interact():
	if not enabled or not can_be_clicked:
		return
		
	send_round_robin(messages)
	complete()
