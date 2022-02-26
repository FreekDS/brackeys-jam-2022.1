extends Interactable

func _ready():
	# The lamp is never really enabled, it does things on state change though
	enable_on = []
	disable_on = []

func _on_gameState_change(level, state):
	if state == StateManager.GARAGE.END and level == StateManager.LEVELS.GARAGE:
		$Sprite.modulate = Color(0.1,0.1,0.1)
		yield(get_tree().create_timer(3), "timeout")
		emit_signal("action_end_level")
		complete()
		print("Level clear")

