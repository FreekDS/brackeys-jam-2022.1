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
	LIVING,
	BATHROOM,
	KITCHEN,
	FINALE
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

enum BATHROOM {
	INIT,
	MIRROR_INTERACTED,	# It cannot hurt
	COLLECT_TOWELS,
	TOWELS_DEPOSITED,	# It might be real
	TOOTHPASTE_TAKEN,
	BRUSH_TAKEN,
	TEETH_BRUSHED,
	SHOWER_OPENED,
	SOAP_TAKEN,
	DRESSER_OPENED,
	HAIR_DRYER_TAKEN,
	MIRROR_INTERACTED_2,
	CAT_EQUIPPED,
	BATH_FILLED,
	END
}

var current_level = null
var current_state = null
var insanity_level = INSANITY.CANNOT_HURT


func change_state(new_state):
	current_state = new_state
	state_meta.clear()
	notify()
	if(current_level==LEVELS.GARAGE && new_state==GARAGE.END):
		current_state=LIVING.INIT
		change_level("Living")
		current_level = LEVELS.LIVING
	elif(current_level==LEVELS.LIVING && new_state==LIVING.END):
		change_level("Bathroom")
		current_level = LEVELS.BATHROOM
	elif(current_level==LEVELS.BATHROOM && new_state==BATHROOM.END):
		change_level("Finale")
		current_level = LEVELS.FINALE


func change_level(new_level):
	
	insanity_level=INSANITY.CANNOT_HURT
	current_state = 0 	# Zero is always init state
	
	#This signal will be picked up in de SceneChanger
	emit_signal("level_changed", new_level)
	notify()
