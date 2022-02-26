extends Interactable


var messages = {
	0: ["It's my third favourite dresser!",
	"I tried to sell this one",
	"It holds my best cutlery"
	],
	1: ["I wonder if I fit in there",
	"Everything in there could break"],
	2: ["All my cutlery is both whole and broken",
	"Until I open the dresser I don't know which it is"
	]
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

