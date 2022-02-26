extends Interactable

var messages = {
	0: ["It's broken",
	"Just like me",
	"Im joking ofcourse"
	],
	1: ["Has it ever worked?",
	"The lamp in is not broken",
	"Why is this circuit broken?"],
	2: ["I like it better this way",
	"Just how I like it"
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
