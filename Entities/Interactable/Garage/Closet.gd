extends Interactable

var keep_disabled = false

var messages = {
	0: ["It is locked, not a key in sight"],
	1: ["It is locked, not a key in sight"],
	2: ["It is locked, a drill in sight"]
}

func _ready():
	enable_on = [
		StateManager.GARAGE.PICKED_UP_PHONE,
		StateManager.GARAGE.DRILL_ACQUIRED
	]
	disable_on = []

func interact():
	if not enabled or not can_be_clicked:
		return
	
	match StateManager.current_state:
		StateManager.GARAGE.DRILL_ACQUIRED:
			specific_message("let me drill this closet open, quickly!")
			yield(get_tree().create_timer(3), "timeout")
#			_on_mouse_exit()
			disable()
			keep_disabled = true
			StateManager.change_state(StateManager.GARAGE.CLOSET_DRILLED)
		_:
			send_round_robin(messages)
	
	complete()


func _on_gameState_change(level, state):
	._on_gameState_change(level, state)
	if keep_disabled:
		disable()



