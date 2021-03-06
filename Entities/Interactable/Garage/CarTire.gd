extends Interactable

var messages = {
	0: [
		"It is a used car tire"
	],
	1: [
		"Yep, that tire is still used"
	],
	2: [
		"No changes here, it is a used tire",
		"The tire has been used already",
		"The tire is unused (just kidding, it is)",
		"Why would you keep a used tire anyway?"
	]
}

func _ready():
	enable_on = [
		StateManager.GARAGE.PICKED_UP_PHONE
	]
	disable_on = []

func interact():
	if not enabled or not can_be_clicked:
		return
	send_round_robin(messages)
	complete()
