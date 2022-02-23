extends Node

signal scene_changed(next_scene)
onready var door=$Game/Interactables/door/


func _ready():
	door.connect("door_clicked",self,"handle_scene_changed")

func handle_scene_changed(next_scene:String):
	print("changing scene")
	emit_signal("scene_changed",next_scene)
