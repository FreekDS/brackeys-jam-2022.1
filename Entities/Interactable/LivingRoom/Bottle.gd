extends Interactable

var messages = {
	0: ["An unopened water bottle",
	"I dislike this brand"
	],
	1: [""],
	2: [""]
}

func _ready():
	enable_on = [
		StateManager.LIVING.THIRSTY
	]
	disable_on = [
		
	]

func interact():
	if not enabled or not can_be_clicked:
		return
		
	match StateManager.current_state:
		StateManager.LIVING.THIRSTY:
			emit_signal("action_message", "Water will help\n*gulp*")
			$AudioStreamPlayer2D.playing = true
			visible = false
			yield(get_tree().create_timer(3), "timeout")
			emit_signal("action_message", "The plant looks thirsty")
			yield(get_tree().create_timer(3), "timeout")
			StateManager.change_state(StateManager.LIVING.BOTTLE_TAKEN)
			complete()
			call_deferred("queue_free")
		_: # default
			emit_signal("action_message", round_robin_message(messages[StateManager.insanity_level]))
			pass
	complete()
