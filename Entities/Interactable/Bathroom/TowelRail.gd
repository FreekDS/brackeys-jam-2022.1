extends Interactable


onready var EmptyRail = $EmptyRail
onready var MySprite = $Sprite

var towel_taken = false

func _ready():
	enable_on = [
		StateManager.BATHROOM.MIRROR_INTERACTED
	]
	disable_on = [
		StateManager.BATHROOM.TOWEL_2,
		StateManager.BATHROOM.TOWELS_DEPOSITED
	]

func take_towel():
	if towel_taken:
		return
	
	EmptyRail.visible = true
	MySprite.visible = false
	towel_taken = true
	disable()

func interact():
	if not enabled or not can_be_clicked:
		return
		
	match StateManager.current_state:
		StateManager.BATHROOM.MIRROR_INTERACTED:
			take_towel()
			StateManager.change_state(StateManager.BATHROOM.TOWEL_1)
		StateManager.BATHROOM.TOWEL_1:
			take_towel()
			StateManager.change_state(StateManager.BATHROOM.TOWEL_2)
			
	
	complete()
	
