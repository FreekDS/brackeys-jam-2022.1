extends Interactable

onready var Sprite1 = $Sprite
onready var OpenSprite = $Box2

func interact():
	if not enabled or not can_be_clicked:
		return
		
	match StateManager.current_state:
		StateManager.LIVING.FISH_FED:
			Sprite1.visible = false
			OpenSprite.visible = true
			emit_signal("action_message", "It is empty")
			yield(get_tree().create_timer(3), "timeout")
			StateManager.insanity_level = StateManager.INSANITY.WILL_HURT
			emit_signal("action_insanity", "IT is REAL, it WILL hurt you!")
			yield(get_tree().create_timer(3), "timeout")
			emit_signal("action_message", "The fish stole my package!")
			yield(get_tree().create_timer(3), "timeout")
			StateManager.change_state(StateManager.LIVING.BOX_INTERACTED)
		_: # default
			pass
	complete()

func _on_gameState_change(_level, state):
	if state == StateManager.LIVING.FISH_FED:
		enable()
