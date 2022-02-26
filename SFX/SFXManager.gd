extends Node

var distorted = false

enum PLAYSTATE {
	MENU,
	LEVELS,
	END
}

onready var MainTheme = $MainTheme
onready var EndTheme = $ItsOverTheme

onready var LevelThemes = {
	StateManager.INSANITY.CANNOT_HURT: null,
	StateManager.INSANITY.MIGHT_HURT: null,
	StateManager.INSANITY.WILL_HURT: null,
	StateManager.INSANITY.HURT: null
}

onready var current_state = PLAYSTATE.MENU

func _ready():
	StateManager.connect("transitioned_to", self, "state_change")
	StateManager.connect("level_changed", self, "on_level_change")


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


func stop_all():
	for c in get_children():
		c.stop()
		

func correct_level_music_playing():
	return LevelThemes[StateManager.insanity_level].playing()

func play_correct_level_music():
	if LevelThemes[StateManager.insanity_level]:
		LevelThemes[StateManager.insanity_level].play()


func _process(delta):
	match current_state:
		PLAYSTATE.MENU:
			if not MainTheme.playing:
				stop_all()
				MainTheme.play()
		PLAYSTATE.LEVELS:
			if not correct_level_music_playing():
				stop_all()
				play_correct_level_music()
		PLAYSTATE.END:
			if not EndTheme.playing:
				stop_all()
				EndTheme.play()


