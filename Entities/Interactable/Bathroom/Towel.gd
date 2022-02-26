extends Interactable


func _ready():
	enable_on = [
		StateManager.BATHROOM.MIRROR_INTERACTED
	]
	disable_on = [
		StateManager.BATHROOM.TOWELS_DEPOSITED
	]

func take_towel():	
	visible = false
	call_deferred("queue_free")

func interact():
	if not enabled or not can_be_clicked:
		return
		
	match StateManager.current_state:
		StateManager.BATHROOM.MIRROR_INTERACTED, StateManager.BATHROOM.COLLECT_TOWELS:
			$AudioStreamPlayer2D.playing = true
			take_towel()
			var prev_meta = StateManager.state_meta.duplicate()
			StateManager.change_state(StateManager.BATHROOM.COLLECT_TOWELS)
			StateManager.state_meta = prev_meta
			StateManager.state_meta['towel2'] = true

	complete()
	

