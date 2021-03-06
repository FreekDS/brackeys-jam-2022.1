extends Interactable

var messages = {
	0: ["This is my favourite dresser"
	],
	1: ["I can fit in this one!",
	"Although I need to remove the shelves"],
	2: ["I would rather be in here",
	"It's my safe-space"
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
