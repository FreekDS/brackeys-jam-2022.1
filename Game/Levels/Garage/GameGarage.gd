extends Node2D

onready var LevelAnimations = $LevelAnimations


func _on_Plongkas_action_end_level():
	LevelAnimations.play("LevelEnd")


func _on_LevelAnimations_animation_finished(anim_name):
	if anim_name == "LevelEnd":
		print("Level ended")
		StateManager.change_level("Living")
