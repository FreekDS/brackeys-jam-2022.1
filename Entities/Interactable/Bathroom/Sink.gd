extends Interactable


var messages = {
	0: ["It's a brand new sink"
	],
	1: ["Let that sink in..."],
	2: ["Sunk cost falacy?"
	]
}

func _ready():
	enable_on = [
		StateManager.BATHROOM.MIRROR_INTERACTED
	]
	disable_on = [
		
	]

func interact():
	if not enabled or not can_be_clicked:
		return
		
	send_round_robin(messages)
	
	complete()
