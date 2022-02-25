extends Interactable

var messages = {
	0: [""],
	1: [""],
	2: [""]
}

onready var Text = $Text

func _ready():
	enable_on = [
		StateManager.LIVING.BOTTLE_TAKEN
	]
	disable_on = [
		
	]

func interact():
	if not enabled or not can_be_clicked:
		return
		
	match StateManager.current_state:
		StateManager.LIVING.BOTTLE_TAKEN:
			emit_signal("action_message", "Poor plant")
			yield(get_tree().create_timer(3), "timeout")
			Text.play_text()
			yield(Text, "completed")
			yield(get_tree().create_timer(1), "timeout")
			StateManager.insanity_level = StateManager.INSANITY.MIGHT_HURT
			emit_signal("action_insanity", "It might be real, what if it hurts?")
			yield(get_tree().create_timer(3), "timeout")
			emit_signal("action_message", "The fish look thirsty too")
			StateManager.change_state(StateManager.LIVING.PLANT_WATERED)
		_: # default
			emit_signal("action_message", round_robin_message(messages[StateManager.insanity_level]))
			pass
	
	complete()
