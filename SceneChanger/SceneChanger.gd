extends Node

onready var stateManager=StateManager
onready var currentLevel=$Main
onready var currentLevelEnum=StateManager.LEVELS.GARAGE

func _ready():
	stateManager.connect("level_changed",self,"handle_level_changed")
	currentLevel.connect("scene_changed",self,"handle_scene_changed")
	
func handle_level_changed(currentLevelName:String):
	var nextLevel
	match currentLevelName:
		"garage":
			nextLevel=load("res://Game/Levels/Garage/Garage.tscn").instance()
			currentLevelEnum=StateManager.LEVELS.GARAGE
		"kitchen":
			nextLevel=load("res://Game/Levels/Kitchen/Kitchen.tscn").instance()
			currentLevelEnum=StateManager.LEVELS.KITCHEN
		_:
			print("unknown level")
			return
	add_child(nextLevel)
	nextLevel.connect("scene_changed",self,"handle_scene_changed")
	currentLevel.queue_free()
	currentLevel=nextLevel
	
func handle_scene_changed(currentLevelName:String):
	var nextLevel
	match currentLevelEnum:
		StateManager.LEVELS.GARAGE:
			match currentLevelName:
				_:
					nextLevel=load("res://Game/Levels/Garage/Garage.tscn").instance()
		StateManager.LEVELS.KITCHEN:
			match currentLevelName:
				"scene1":
					nextLevel=load("res://Game/Levels/Kitchen/Kitchen.tscn").instance()
				"scene2":
					nextLevel=load("res://Game/Levels/Kitchen/Kitchen_scene2.tscn").instance()
				_:
					nextLevel=load("res://Game/Levels/Kitchen/Kitchen.tscn").instance()
		_:
			print("unknown scene")
			return
	add_child(nextLevel)
	nextLevel.connect("scene_changed",self,"handle_scene_changed")
	currentLevel.queue_free()
	currentLevel=nextLevel
	


