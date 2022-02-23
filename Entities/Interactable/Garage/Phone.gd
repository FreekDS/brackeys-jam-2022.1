extends Interactable
class_name Telephone

onready var TextPos = $TextPos
onready var Text = $Text
onready var PhoneLight = $Sprite/Light2D
onready var PhoneAnimations = $TelephoneAnimations

var going_over = false

func interact():
	if not can_be_clicked:
		return
	if going_over:
		deactivate()
	else:
		activate()
	.interact()


func activate(dont_emit=false):
	going_over = true
	PhoneAnimations.play("ring")
	Text.set_content("*ring ring*")
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

