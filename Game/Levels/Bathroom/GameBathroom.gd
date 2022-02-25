extends Node2D


func _on_LevelAnimations_animation_finished(anim_name):
	if anim_name == "LevelEnd":
		print("Level ended")

func _on_Bathtub_action_end_level():
	$LevelAnimations.play("LevelEnd")
