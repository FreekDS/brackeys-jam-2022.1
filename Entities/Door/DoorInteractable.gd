extends "res://Entities/Interactable/Interactable.gd"

signal door_clicked(next_scene)

export (String ) var next_scene="test"

	
func set_scene(value):
	next_scene = value

func interact():
	if can_be_clicked:
		print("Hehe door interaction")
		emit_signal("door_clicked",next_scene)


func _on_Area2D_mouse_entered():
	_on_mouse_over()


func _on_Area2D_mouse_exited():
	_on_mouse_exit()
	
#hjelp animations broke
func play_anim(back = false):
	can_be_clicked = not back

	
