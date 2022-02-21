extends Interactable

signal door_clicked(next_scene)

export (String ) var next_scene="test"

func _ready():
	animations = $AnimationPlayer

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
