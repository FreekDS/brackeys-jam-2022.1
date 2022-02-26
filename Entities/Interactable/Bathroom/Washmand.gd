extends Interactable


var towel_count = 0

func _ready():
	enable_on = [
		StateManager.BATHROOM.MIRROR_INTERACTED
	]
	disable_on = [
		StateManager.BATHROOM.TOWELS_DEPOSITED
	]

func interact():
	if not enabled or not can_be_clicked:
		return
		
	match StateManager.current_state:
		StateManager.BATHROOM.MIRROR_INTERACTED:
			specific_message("I should clean the dirty towels...")
			yield(get_tree().create_timer(1), "timeout")
		StateManager.BATHROOM.COLLECT_TOWELS:
			if StateManager.state_meta.has('towel1') and StateManager.state_meta.has('towel2'):
				specific_message("I found them all!")
				StateManager.change_state(StateManager.BATHROOM.TOWELS_DEPOSITED)
				complete()
				return
			for key in ['towel1', 'towel2']:
				if StateManager.state_meta.has(key):
					StateManager.state_meta.erase(key)
					specific_message("Here's a towel")
					towel_count += 1
					yield(get_tree().create_timer(1), "timeout")
					break
			if towel_count < 2:
				specific_message("There is one more")
				yield(get_tree().create_timer(1), "timeout")

	if towel_count >= 2:
		specific_message("I found them all")
		StateManager.change_state(StateManager.BATHROOM.TOWELS_DEPOSITED)
		disable()
	
	complete()