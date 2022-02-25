extends Interactable

onready var Sprite = $Sprite

var opened = false

func _ready():
	enable_on = [
		StateManager.GARAGE.PICKED_UP_PHONE
	]
	disable_on = []

func interact():
	if not enabled or not can_be_clicked:
		return
	
	match StateManager.current_state:
		StateManager.GARAGE.PICKED_UP_PHONE:
			if opened:
				specific_message("Monday 14th of February:\n[i]\"IT HURT! IT HURT! IT HURT\"[/i]")
				yield(get_tree().create_timer(4), "timeout")
				StateManager.insanity_level = StateManager.INSANITY.MIGHT_HURT
				emit_signal("action_insanity", "It might be real, what if it hurts?")
				yield(get_tree().create_timer(4), "timeout")
				StateManager.change_state(StateManager.GARAGE.DIARY_OPENED)
			else:
				specific_message("It is my diary\n*opens*")
				opened = true
	complete()
