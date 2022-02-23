extends Node


signal transitioned_to(level, state)
signal level_changed(level)

func _ready():
	current_level = LEVELS.GARAGE
	current_state = GARAGE.INIT


func notify():
	emit_signal("transitioned_to", current_level, current_state)


enum LEVELS {
	GARAGE ,
	KITCHEN
}


var state_meta = {}

enum INSANITY {
	CANNOT_HURT,
	MIGHT_HURT,
	WILL_HURT,
	HURT
}

enum GARAGE {
	INIT,
	PICKED_UP_PHONE,
	DIARY_OPENED,
	PHONE_NUMBER_FOUND,
	PHONE_DIALED,
	DRILL_ACQUIRED,
	CLOSET_DRILLED,
	END
}

var current_level = null
var current_state = null
var insanity_level = INSANITY.CANNOT_HURT


func change_state(new_state):
	current_state = new_state
	state_meta.clear()
	notify()
	if(new_state==GARAGE.END):
		change_level("kitchen")
		


func change_level(new_level):
	current_level = new_level
	#This signal will be picked up in de SceneChanger
	emit_signal("level_changed", new_level)
	notify()
