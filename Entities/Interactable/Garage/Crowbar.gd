extends Interactable

func _ready():
	enable_on = [
		StateManager.GARAGE.CLOSET_DRILLED
	]
	disable_on = []


func interact():
	if not enabled or not can_be_clicked:
		return
	specific_message("I will make good use out of this, its time has come")
	visible = false
	yield(get_tree().create_timer(3), "timeout")
	StateManager.state_meta['items'] = ['crowbar']
	complete()
	queue_free()


func _on_gameState_change(level, state):
	._on_gameState_change(level, state)
	if state in enable_on:
		visible = true
