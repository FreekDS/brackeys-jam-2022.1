extends Control


func _ready():
	SfxManager.current_state = SfxManager.PLAYSTATE.END
	$RichTextLabel2.visible = false
	pass

func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().quit()
		
func _process(delta):
	if not $RichTextLabel2.visible:
		yield(get_tree().create_timer(3),"timeout")
		$RichTextLabel2.visible = true
		

