extends Node


onready var currentState = GameStates.GARAGE.INIT
signal state_changed(state)


func _ready():
	for c in get_children():
		connect("state_changed", c, "handle")
	call_deferred("emit_signal", "state_changed", currentState)
