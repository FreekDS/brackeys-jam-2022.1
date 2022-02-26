tool
extends Interactable


const REQUIRED_TIME = 3	# in seconds

onready var particles = $Water

var filling = false
var fill_start = 0

var time_passed = 0

func _ready():
	enable_on = [
		StateManager.BATHROOM.CAT_EQUIPPED
	]
	disable_on = [
		StateManager.BATHROOM.END
	]
	particles.emitting = false
	
func interact():
	if not enabled or not can_be_clicked:
		return
	
	emit_signal("on_interact", "bathtub")
	if time_passed == 0 and not filling:
		specific_message("Let me fill this bath")
		$AudioStreamPlayer2D.playing = true
		fill_start = OS.get_unix_time()
		filling = true
		particles.emitting = true
		complete()
		return
	
	if time_passed >= REQUIRED_TIME:
		StateManager.insanity_level = StateManager.INSANITY.HURT
		emit_signal("action_insanity", "IT HURT")
		yield(get_tree().create_timer(4), "timeout")
		StateManager.change_state(StateManager.BATHROOM.END)
		emit_signal("action_end_level")
		complete()
		return
	
	if filling:
		time_passed += OS.get_unix_time() - fill_start
		filling = false
		particles.emitting = false
	else:
		fill_start = OS.get_unix_time()
		filling = true
		particles.emitting = true
	complete()

func _process(_delta):
	if filling:
		time_passed += OS.get_unix_time() - fill_start
		fill_start = OS.get_unix_time()
		if time_passed >= REQUIRED_TIME:
			filling = false
			specific_message("The bath is full")
			particles.emitting = false
			complete()


