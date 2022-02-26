extends Node

var distorted = false

func _ready():
	$MainTheme.play()
	$MainTheme.stream_paused = false
	StateManager.connect("transitioned_to", self, "state_change")


func state_change(_level, state):
	if StateManager.insanity_level in [StateManager.INSANITY.WILL_HURT, StateManager.INSANITY.HURT]:
		if not distorted:
			$MainTheme.stop()
			$ItsOverTheme.play()
		distorted = true
	elif distorted and not $ItsOverTheme.playing:
		$MainTheme.play()
		$ItsOverTheme.stop()
		distorted = false
