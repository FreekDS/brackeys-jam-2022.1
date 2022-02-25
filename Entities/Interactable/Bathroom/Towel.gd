extends Interactable


func _ready():
	enable_on = [
		StateManager.BATHROOM.MIRROR_INTERACTED
	]
	disable_on = [
		StateManager.BATHROOM.TOWEL_2,
		StateManager.BATHROOM.TOWELS_DEPOSITED
	]

func take_towel():	
	visible = false
	call_deferred("queue_free")

func interact():
	if not enabled or not can_be_clicked:
		return
		
	match StateManager.current_state:
		StateManager.BATHROOM.MIRROR_INTERACTED:
			StateManager.change_state(StateManager.BATHROOM.TOWEL_1)
			take_towel()
		StateManager.BATHROOM.TOWEL_1:
			StateManager.change_state(StateManager.BATHROOM.TOWEL_2)
			take_towel()

	complete()
	

