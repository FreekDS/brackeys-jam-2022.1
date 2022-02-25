extends Interactable

onready var Text = $Text

func _ready():
	enable_on = [
		StateManager.BATHROOM.INIT
	]
	disable_on = []


var mirror_talks = [
	"You look handsome",
	"There is something stuck \nin your teeth",
	"It is barber time!",
	"Oi fatty!"
]


func interact():
	if not enabled or not can_be_clicked:
		return
	
	emit_signal("on_interact", "mirror")	# makes sure to trigger pause functionality
	
	match StateManager.current_state:
		StateManager.BATHROOM.INIT:
			Text.set_content("It is not real, it cannot hurt you!")
			Text.play_text()
			yield(Text, "completed")
			yield(get_tree().create_timer(1), "timeout")
			emit_signal("action_insanity", "It is not real, it cannot hurt you")
			yield(get_tree().create_timer(4), "timeout")
			StateManager.insanity_level = StateManager.INSANITY.CANNOT_HURT
			specific_message("It is not real, it cannot hurt me...")
			StateManager.change_state(StateManager.BATHROOM.MIRROR_INTERACTED)
		
		StateManager.BATHROOM.TOWELS_DEPOSITED:
			Text.set_content("Seriously,\nBrush your teeth man!")
			Text.play_text()
			yield(Text, "completed")
		_:	# default
			var t = mirror_talks[randi() % mirror_talks.size()]
			Text.set_content("[center]"+ t + "[/center]")
			Text.play_text()
			yield(Text, "completed")

	complete()
