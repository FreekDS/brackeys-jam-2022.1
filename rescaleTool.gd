tool
extends EditorScript



var parentName = "InteractablesBack"
var scale = Vector2(6.5, 6.5)


func _run():
	var parent = get_scene().find_node(parentName)
	var c: Node2D
	for d in parent.get_children():
		d.set_scale(scale)
		d.debug_draw = false

