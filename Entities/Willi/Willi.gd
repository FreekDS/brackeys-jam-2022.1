extends Interactable


var sleeping = true
onready var WillyAnimations = $WilliAnimations
onready var Text = $Text


func _ready():
	enable_on = [
		StateManager.BATHROOM.INIT
	]
	disable_on = []
	WillyAnimations.play("sleep")
	

func change_awake():
	if sleeping:
		WillyAnimations.play("wash")
		$AudioStreamPlayer2D2.playing = true
		sleeping = false
	else:
		WillyAnimations.play("sleep")
		$AudioStreamPlayer2D.playing = true
		sleeping = true


func interact():
	if not enabled or not can_be_clicked:
		return

	
	if StateManager.current_state == StateManager.BATHROOM.MIRROR_INTERACTED_2:
		specific_message("You will never hurt me anymore, ANIMAL")
		visible = false
		yield(get_tree().create_timer(2), "timeout")
		specific_message("Time to take a bath")
		complete()
		StateManager.change_state(StateManager.BATHROOM.CAT_EQUIPPED)
		call_deferred("queue_free")
		return
	
	# TODO: make cat say evil things on insanity
	
	change_awake()
	if sleeping:
		Text.set_content(
			"[center]" +
				"*prrr prrr*" +
			"[/center]"
		)
	else:
		Text.set_content(
			"[center]" + 
				"meow?" +
			"[/center]")
	
	Text.play_text()
	yield(Text, "completed")
	complete()

