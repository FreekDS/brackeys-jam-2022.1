extends Interactable


func _ready():
	enable_on = [
		StateManager.BATHROOM.SOAP_TAKEN
	]
	disable_on = [
		StateManager.BATHROOM.DRESSER_OPENED
	]


func interact():
	if not enabled or not can_be_clicked:
		return
		
	specific_message("Whats in here?")
	yield(get_tree().create_timer(1), "timeout")
	StateManager.change_state(StateManager.BATHROOM.DRESSER_OPENED)
	complete()
