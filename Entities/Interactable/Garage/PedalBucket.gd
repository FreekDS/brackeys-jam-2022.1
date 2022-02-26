extends Interactable
tool

onready var Sprite = $Sprite

var opened = false

func _ready():
	enable_on = [
		StateManager.GARAGE.PICKED_UP_PHONE
	]
	disable_on = []


func interact():
	if not enabled or not can_be_clicked:
		return
	
	$AudioStreamPlayer2D.playing = true
	match StateManager.current_state:
		StateManager.GARAGE.PHONE_DIALED:
			if opened:
				if StateManager.state_meta.has('items'):
					if StateManager.state_meta['items'].has('batteries'):
						Sprite.frame = 0
						opened = false
						return
				specific_message("Hey, whats this?")
				yield(get_tree().create_timer(2), "timeout")
				specific_message("There are batteries in here!")
				if not StateManager.state_meta.has('items'):
					StateManager.state_meta['items'] = []
				StateManager.state_meta['items'].append('batteries')
			else:
				Sprite.frame = 1
				opened = true
		_:
			if opened:
				Sprite.frame = 0
				opened = false
			else:
				Sprite.frame = 1
				opened = true
	complete()

