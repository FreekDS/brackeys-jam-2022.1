extends Interactable


onready var ScreenNoise = $Screen/Noise
onready var AhDeRikSe = $"Screen/Ah de rik se"
onready var Text = $Text

onready var TVAnimations = $TeleviesAnimations


var active = true

func _ready():
	enable_on = [
		StateManager.LIVING.INIT
	]
	disable_on = [

	]
	modulate = Color(1.3, 1.3, 1.3)


func interact():
	if not enabled or not can_be_clicked:
		return
	
	match StateManager.current_state:
		StateManager.LIVING.INIT:
			# TV interactie
			emit_signal("on_interact", self.name)
			Text.play_text()
			yield(Text, "completed")
			turn_off()
			$AudioStreamPlayer2D.playing = true
			StateManager.insanity_level = StateManager.INSANITY.CANNOT_HURT
			emit_signal("action_insanity", "It is not real, it cannot hurt you!")
			yield(get_tree().create_timer(3), "timeout")
			emit_signal("action_message", "It is not real, it cannot hurt me...")
			yield(get_tree().create_timer(3), "timeout")
			StateManager.change_state(StateManager.LIVING.TV_INTERACTED)
		_:	# Default
			$AudioStreamPlayer2D.playing = true
			if active:
				turn_off()
			else:
				turn_on()
	complete()

func turn_off():
	TVAnimations.play("turn_off")
	active = false
	modulate = Color(1,1,1)
	$Dansen.playing = false
	
func turn_on():
	if StateManager.current_state >= StateManager.LIVING.PLANT_WATERED:
		ScreenNoise.visible = false
		AhDeRikSe.visible = true
		$Dansen.playing = true
	TVAnimations.play("turn_on")
	active = true
	modulate = Color(1.3,1.3,1.3)
		
func _on_gameState_change(_level, state):
	._on_gameState_change(_level, state)
	if state in enable_on:
		ScreenNoise.visible = true
		AhDeRikSe.visible = false
		
