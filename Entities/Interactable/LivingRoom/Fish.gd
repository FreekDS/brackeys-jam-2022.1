extends Interactable

onready var Text = $Text

var messages = {
	0: [""],
	1: [""],
	2: [""]
}

func _ready():
	enable_on = [
		StateManager.LIVING.PLANT_WATERED
	]
	disable_on = [
		
	]

func interact():
	if not enabled or not can_be_clicked:
		return
	
	
	match StateManager.current_state:
		StateManager.LIVING.PLANT_WATERED:
			emit_signal("action_message", "Here for you fish!")
			$AudioStreamPlayer2D5.playing = true
			yield(get_tree().create_timer(3), "timeout")
			Text.play_text()
			yield(Text, "completed")
			StateManager.change_state(StateManager.LIVING.FISH_WATERED)
		StateManager.LIVING.FOOD_TAKEN:
			Text.set_content("*Nom*")
			$AudioStreamPlayer2D.playing = true
			Text.play_text()
			yield(Text, "completed")
			yield(get_tree().create_timer(0.5), "timeout")
			emit_signal("action_message", "Not even a thank you\nHow ungrateful!")
			StateManager.change_state(StateManager.LIVING.FISH_FED)
		StateManager.LIVING.GUN_TAKEN:
			emit_signal("action_message", "TAKE THIS")
			yield(get_tree().create_timer(2), "timeout")
			StateManager.insanity_level = StateManager.INSANITY.HURT
			emit_signal("action_insanity", "IT HURT")
			$AudioStreamPlayer2D2.playing = true
			yield(get_tree().create_timer(4), "timeout")
			emit_signal("action_end_level")
			StateManager.change_state(StateManager.LIVING.END)
		_: # default
			emit_signal("action_message", round_robin_message(messages[StateManager.insanity_level]))
	
	complete()
