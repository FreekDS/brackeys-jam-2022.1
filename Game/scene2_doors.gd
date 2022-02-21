extends Node

signal level_changed(next_scene)
onready var door=$Game/Interactables/door/


func _ready():
	door.connect("door_clicked",self,"handle_level_changed")

func handle_level_changed(next_scene:String):
	emit_signal("level_changed",next_scene)
