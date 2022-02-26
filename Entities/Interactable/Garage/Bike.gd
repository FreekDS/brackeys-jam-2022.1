extends Interactable

var messages = [
	"Mom said: there is a time and place for everything, \nbut not now!"
]

func _ready():
	enable_on = [
		StateManager.GARAGE.PICKED_UP_PHONE
	]
	disable_on = [
		
	]

func interact():
	if can_be_clicked and enabled:
		$AudioStreamPlayer2D.playing = true
		specific_message(messages[0])
		complete()
