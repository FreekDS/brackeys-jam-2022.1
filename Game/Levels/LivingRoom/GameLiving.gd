extends Node2D



func _on_Fish_action_end_level():
	$LevelAnimations.play("LevelEnd")


func _on_LevelAnimations_animation_finished(anim_name):
	if anim_name == "LevelEnd":
		print("Level end")
		StateManager.change_level("Bathroom")
