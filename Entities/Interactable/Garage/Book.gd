extends Interactable

onready var Sprite = $Sprite

var opened = false

func interact():
	if not enabled or not can_be_clicked:
		return
	
	match StateManager.current_state:
		StateManager.GARAGE.PICKED_UP_PHONE:
			if opened:
				emit_signal("action_message", "Monday 14th of February:\n[i]\"IT HURT! IT HURT! IT HURT\"[/i]")
				yield(get_tree().create_timer(4), "timeout")
				StateManager.insanity_level = StateManager.INSANITY.MIGHT_HURT
				emit_signal("action_insanity", "It might be real, what if it hurts?")
				yield(get_tree().create_timer(4), "timeout")
				StateManager.change_state(StateManager.GARAGE.DIARY_OPENED)
			else:
				emit_signal("action_message", "It is my diary\n*opens*")
				opened = true


func _on_gameState_change(_level, state):
	if state in [StateManager.GARAGE.PICKED_UP_PHONE]:
		enabled = true
