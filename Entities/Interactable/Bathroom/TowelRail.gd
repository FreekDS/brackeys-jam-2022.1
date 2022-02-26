extends Interactable


onready var EmptyRail = $EmptyRail
onready var MySprite = $Sprite

var towel_taken = false

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
	
	complete()
	
