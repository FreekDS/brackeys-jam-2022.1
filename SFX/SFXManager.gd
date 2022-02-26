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
	var at = 0
	for c in get_children():
		if c.playing:
			c.stop()
			at = MainTheme.get_playback_position()
	return at
		

func correct_level_music_playing():
	if not LevelThemes[StateManager.insanity_level]:
		return
	return LevelThemes[StateManager.insanity_level].playing

func play_correct_level_music(at):
	if LevelThemes[StateManager.insanity_level]:
		LevelThemes[StateManager.insanity_level].play(at)


func _process(delta):
	match current_state:
		PLAYSTATE.MENU:
			if not MainTheme.playing:
				var at = stop_all()
				MainTheme.play(at)
		PLAYSTATE.LEVELS:
			if not correct_level_music_playing():
				var at = stop_all()
				play_correct_level_music(at)
		PLAYSTATE.END:
			if not EndTheme.playing:
				var at = stop_all()
				EndTheme.play(at)


