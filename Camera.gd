extends Camera2D


export(NodePath) var TrackingObject = null

var tween = Tween.new()
onready var obj : KinematicBody2D = get_node(TrackingObject)

func _ready():
	add_child(tween)

func _process(_delta):
	if global_position.x != obj.global_position.x:
		tween.interpolate_property(self, "global_position:x", 
			global_position.x, obj.global_position.x, 0.2, 
			Tween.TRANS_LINEAR, Tween.EASE_OUT_IN
		)
		tween.start()
