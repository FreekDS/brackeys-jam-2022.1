extends Interactable


var messages = {
	0: ["THE DAMN FISH STOLE THEM ALL",
	"DIRTLY LITTLE ANIMAL",
	"YOU DRINK MY WATER, EAT MY FOOD AND STEAL!"
	],
	1: ["THE DAMN FISH STOLE THEM ALL",
	"DIRTLY LITTLE ANIMAL",
	"YOU DRINK MY WATER, EAT MY FOOD AND STEAL!"],
	2: ["THE DAMN FISH STOLE THEM ALL",
	"DIRTLY LITTLE ANIMAL",
	"YOU DRINK MY WATER, EAT MY FOOD AND STEAL!"]
}

func _ready():
	enable_on = [
		StateManager.LIVING.BOX_INTERACTED
	]
	disable_on = [
		
	]

func interact():
	if not enabled or not can_be_clicked:
		return
		
	send_round_robin(messages)
	
	complete()
