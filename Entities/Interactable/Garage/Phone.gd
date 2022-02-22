extends Interactable


onready var TextPos = $TextPos
onready var Text = $Text
onready var PhoneAnimations = $TelephoneAnimations

var going_over = false
var times_clicked = 0

func interact():
	if not can_be_clicked:
		return
	if going_over:
		PhoneAnimations.stop(true)
		if times_clicked == 3:
			times_clicked += 1
			emit_signal("action_insanity", "Stoemen telefon")
		Text.percent_visible = 0
		going_over = false
	else:
		PhoneAnimations.play("ring")
		times_clicked += 1
		going_over = true
	

	
