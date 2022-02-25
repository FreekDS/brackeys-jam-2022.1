extends Interactable


func _ready():
	enable_on = [
		StateManager.BATHROOM.TOOTHPASTE_TAKEN
	]

func interact():
	if not enabled or not can_be_clicked:
		return
		
	emit_signal("action_message", "*brushes teeth*")
	visible = false
	StateManager.change_state(StateManager.BATHROOM.TEETH_BRUSHED)
	call_deferred("queue_free")
	complete()
