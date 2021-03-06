extends Interactable
class_name Telephone

onready var TextPos = $TextPos
onready var Text = $Text
onready var PhoneLight = $Sprite/Light2D
onready var PhoneAnimations = $TelephoneAnimations

var going_over = false


var phone_text = ""

signal text_sequence_completed


func interact():
	if not can_be_clicked or not enabled:
		return
	
	emit_signal("action_telephone", going_over)
		
	match StateManager.current_state:
		StateManager.GARAGE.INIT:
			deactivate()
			Text.set_content("Remember: it is not real, \nit cannot hurt you!")
			Text.play_text()
			$AudioStreamPlayer2D.playing = false
			yield(Text, "completed")
			emit_signal("action_insanity", "It is not real, it cannot hurt you!")
			yield(get_tree().create_timer(4.0), "timeout")
			specific_message("It is not real, it cannot hurt me...")
			StateManager.change_state(StateManager.GARAGE.PICKED_UP_PHONE)
		StateManager.GARAGE.DIARY_OPENED:
			if StateManager.state_meta.has('items'):
				if StateManager.state_meta['items'].has('phone_number'):
					specific_message("Let me enter the phone number...")
					$AudioStreamPlayer2D2.playing = true
					yield(get_tree().create_timer(3), "timeout")
					activate(true)
					_text_sequence([
						"Uhhm? Hello?",
						"You know that IT IS REAL, Right?",
						"The electricity, it feels so odd",
						"Find a way to get the crowbar \nfrom the closet",
						"HURRY, IT WILL HURT YOU",
						"*clicks*"
					])
					yield(self, "text_sequence_completed")
					deactivate(true)
					$AudioStreamPlayer2D3.playing = true
					StateManager.insanity_level = StateManager.INSANITY.WILL_HURT
					StateManager.current_state = StateManager.GARAGE.PHONE_DIALED
					emit_signal("action_insanity", "IT IS REAL, IT WILL HURT YOU!")
					complete()
					return
			
			specific_message("So many possible phone numbers to dial...")
		
		_:
			specific_message("So many possible phone numbers to dial...")
			complete()
	complete()

func _text_sequence(texts):
	for t in texts:
		Text.set_content(t)
		yield(Text, "completed")
	emit_signal("text_sequence_completed")


func activate(dont_emit=false):
	going_over = true
	PhoneAnimations.play("ring")
	going_over = true
	if not dont_emit:
		emit_signal("action_telephone", going_over)


func deactivate(dont_emit=false):
	going_over = false
	if not dont_emit:
		emit_signal("action_telephone", going_over)
	PhoneAnimations.stop(true)
	Text.percent_visible = 0
	PhoneLight.scale = Vector2.ZERO


func _on_gameState_change(level, state):
	current_message = 0
	enabled = true
	match level:
		StateManager.LEVELS.GARAGE:
			match state:
				StateManager.GARAGE.INIT:
					$AudioStreamPlayer2D.playing = true
					Text.set_content("*ring ring*")
					activate(true)
