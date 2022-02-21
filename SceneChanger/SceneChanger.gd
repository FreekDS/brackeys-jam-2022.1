extends Node

onready var currentLevel=$Main 

func _ready():
	currentLevel.connect("level_changed",self,"handle_level_changed")
	
func handle_level_changed(currentLevelName:String):
	var nextLevel
	match currentLevelName:
		"Main":
			nextLevel=load("res://Game/Game.tscn").instance()
		"scene2":
			nextLevel=load("res://Game/scene2_doors.tscn").instance()
		_:
			print("unknown level")
			return
	add_child(nextLevel)
	nextLevel.connect("level_changed",self,"handle_level_changed")
	currentLevel.queue_free()
	currentLevel=nextLevel

