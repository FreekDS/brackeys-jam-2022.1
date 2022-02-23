extends Interactable


func interact():
	if not enabled or not can_be_clicked:
		return
	
	emit_signal("action_message", "I will make good use out of this")
	visible = false
	yield(get_tree().create_timer(3), "timeout")
	StateManager.state_meta['items'] = ['crowbar']
	queue_free()

func _on_gameState_change(_level, state):
	if state in [StateManager.GARAGE.CLOSET_DRILLED]:
		enabled = true
		visible = true
