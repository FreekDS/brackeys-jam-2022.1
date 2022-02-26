extends Interactable


func _ready():
	enable_on = [
		StateManager.BATHROOM.DRESSER_OPENED
	]


func _on_gameState_change(_level, state):
	._on_gameState_change(_level, state)
	if state in enable_on:
		visible = true


func interact():
	if not enabled or not can_be_clicked:
		return
		
	specific_message("One more thing to collect >:)")
	visible = false
	yield(get_tree().create_timer(1), "timeout")
	StateManager.change_state(StateManager.BATHROOM.HAIR_DRYER_TAKEN)
	complete()
	call_deferred("queue_free")

