extends Interactable

var messages = {
	0: ["It is 5 before 12"
	],
	1: ["It is 12 befive 4"],
	2: ["It is time."
	]
}

func _ready():
	enable_on = [
		StateManager.LIVING.TV_INTERACTED
	]
	disable_on = [
		
	]

func interact():
	if not enabled or not can_be_clicked:
		return
		
	send_round_robin(messages)
	
	complete()
