extends Interactable

var messages = {
	0: [""],
	1: [""],
	2: [""]
}

onready var RollAnimation = $RollTween
onready var map_node = $Sprite



func _ready():
	enable_on = [
		StateManager.LIVING.MAP_CHECKED
	]
	disable_on = [
		
	]
	RollAnimation.interpolate_property(
		map_node, "scale:y", map_node.scale.y, 0.2, 0.2
	)


func interact():
	if not enabled or not can_be_clicked:
		return
		
	match StateManager.current_state:
		StateManager.LIVING.BOX_INTERACTED:
			RollAnimation.start()
		_: # default
			emit_signal("action_message", round_robin_message(messages[StateManager.insanity_level]))
			pass
	complete()


func _on_roll_complete(_object, _key):
	$Area2D.visible = false
	StateManager.change_state(StateManager.LIVING.MAP_CHECKED)
