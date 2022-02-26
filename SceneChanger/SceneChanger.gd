extends Node

onready var stateManager=StateManager
onready var currentLevel=$Main
onready var currentLevelEnum=StateManager.LEVELS.GARAGE

func _ready():
	stateManager.connect("level_changed",self,"handle_level_changed")
#	currentLevel.connect("scene_changed",self,"handle_scene_changed")
	StateManager.notify()
	
func handle_level_changed(currentLevelName:String):
	var nextLevel
	match currentLevelName:
		"garage":
			nextLevel=load("res://Game/Levels/Garage/Garage.tscn").instance()
			currentLevelEnum=StateManager.LEVELS.GARAGE
		"Living":
			nextLevel=load("res://Game/Levels/LivingRoom/LivingRoom.tscn").instance()
			currentLevelEnum=StateManager.LEVELS.LIVING
		"Bathroom":
			nextLevel=load("res://Game/Levels/Bathroom/Bathroom.tscn").instance()
			currentLevelEnum=StateManager.LEVELS.BATHROOM
		"Finale":
			nextLevel=load("res://Game/Levels/Finale/FInale.tscn").instance()
		_:
			print("unknown level")
			return
	add_child(nextLevel)
#	nextLevel.connect("scene_changed",self,"handle_scene_changed")
	currentLevel.queue_free()
	currentLevel=nextLevel
	
func handle_scene_changed(currentLevelName:String):
	var nextLevel
	match currentLevelEnum:
		StateManager.LEVELS.GARAGE:
			match currentLevelName:
				_:
					nextLevel=load("res://Game/Levels/Garage/Garage.tscn").instance()
		StateManager.LEVELS.LIVING:
			match currentLevelName:
				_:
					nextLevel=load("res://Game/Levels/LivingRoom/LivingRoom.tscn").instance()
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
#	nextLevel.connect("scene_changed",self,"handle_scene_changed")
	currentLevel.queue_free()
	currentLevel=nextLevel
	


