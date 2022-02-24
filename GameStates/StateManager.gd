extends Node


signal transitioned_to(level, state)
signal level_changed(level)

func _ready():
	current_level = LEVELS.LIVING
	current_state = LIVING.INIT


func notify():
	emit_signal("transitioned_to", current_level, current_state)


enum LEVELS {
<<<<<<< HEAD
	GARAGE ,
	KITCHEN
=======
	GARAGE,
	LIVING
>>>>>>> 27b825add8c3520f17189e9538bc061a69be7623
}


var state_meta = {}

enum INSANITY {
	CANNOT_HURT = 0,
	MIGHT_HURT = 1,
	WILL_HURT = 2,
	HURT = 3
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

enum LIVING {
	INIT,
	TV_INTERACTED,
	THIRSTY,
	BOTTLE_TAKEN,
	PLANT_WATERED,	# increase insanity
	FISH_WATERED,
	FOOD_TAKEN,
	FISH_FED,
	BOX_INTERACTED,	# increase insanity
	MAP_CHECKED,
	GUN_TAKEN,
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
