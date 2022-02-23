extends Interactable


func _on_gameState_change(_level, state):
	if state == StateManager.GARAGE.END:
		$Sprite.modulate = Color(0.1,0.1,0.1)
		yield(get_tree().create_timer(3), "timeout")
		emit_signal("action_end_level")
		complete()
		print("Level clear")

