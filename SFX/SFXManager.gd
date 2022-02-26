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
	StateManager.INSANITY.CANNOT_HURT: $Insane0,
	StateManager.INSANITY.MIGHT_HURT: $Insane1,
	StateManager.INSANITY.WILL_HURT: $Insane2,
	StateManager.INSANITY.HURT: null
}


onready var current_state = PLAYSTATE.MENU


func stop_all():
	for c in get_children():
		c.stop()
		

func correct_level_music_playing():
	if not LevelThemes[StateManager.insanity_level]:
		return
	return LevelThemes[StateManager.insanity_level].playing

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


