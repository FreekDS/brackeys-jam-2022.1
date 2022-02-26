extends Interactable


onready var EmptyRail = $EmptyRail
onready var MySprite = $Sprite

var towel_taken = false

var messages = {
	0: ["I use it to store towels",
	"It can't be used for much more",
	"It's to low for pull-ups"
	],
	1: ["I once tried standing on it",
	"It broke"],
	2: ["I would look better with candles on it"
	]
}

func _ready():
	enable_on = [
		StateManager.BATHROOM.MIRROR_INTERACTED
	]
	disable_on = [
		StateManager.BATHROOM.TOWELS_DEPOSITED
	]

func take_towel():
	if towel_taken:
		return
	
	EmptyRail.visible = true
	MySprite.visible = false
	towel_taken = true
	disable()

func interact():
	if not enabled or not can_be_clicked:
		return
		
	match StateManager.current_state:
		StateManager.BATHROOM.MIRROR_INTERACTED, StateManager.BATHROOM.COLLECT_TOWELS:
			take_towel()
			var prev_meta = StateManager.state_meta.duplicate()
			StateManager.change_state(StateManager.BATHROOM.COLLECT_TOWELS)
			StateManager.state_meta = prev_meta
			StateManager.state_meta['towel1'] = true
	
	if towel_taken:
		send_round_robin(messages)
	
	complete()
	
