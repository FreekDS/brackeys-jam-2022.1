tool
extends Interactable

var messages = {
	0: ["A bulletin board."],
	1: ["A bulletin board!"],
	2: ["A bulletin board?"]
}

func _ready():
	enable_on = [
		StateManager.GARAGE.DIARY_OPENED,
		StateManager.GARAGE.PICKED_UP_PHONE
	]
	disable_on = [
		
	]

func interact():
	if not enabled or not can_be_clicked:
		return
	
	match StateManager.current_state:
		StateManager.GARAGE.DIARY_OPENED:
			if StateManager.state_meta.has('items'):
				if StateManager.state_meta['items'].has('phone_number'):
					return
			specific_message("There is a note on the billboard\nWritten in my own handwriting:")
			yield(get_tree().create_timer(3), "timeout")
			specific_message("*If you can read this, dial 0069021210420*")
			if not StateManager.state_meta.has('items'):
				StateManager.state_meta['items'] = []
			StateManager.state_meta['items'].append('phone_number')
			disable()
		_:
			send_round_robin(messages)
	complete()
