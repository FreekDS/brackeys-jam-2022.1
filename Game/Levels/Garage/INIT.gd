extends State

export(NodePath) var TelephonePath
onready var telephone = get_node(TelephonePath) as Telephone

func handle(state):
	if state == GameStates.GARAGE.INIT:
		telephone.activate(true)
#		emit_signal("change_state", GameStates.GARAGE.WAIT_PICKUP)
	
		
	
