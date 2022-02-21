extends Camera2D

export(NodePath) var TrackingObject = null
export(NodePath) var LeftMost = null
export(NodePath) var RightMost = null

export(bool) var stopAtEdge = false

export(int) var minX = 0
export(int) var maxX = 4000

var tween = Tween.new()
onready var obj : KinematicBody2D = get_node(TrackingObject)

func _ready():
	add_child(tween)
	if LeftMost:
		minX = get_node(LeftMost).global_position.x
	if RightMost:
		maxX = get_node(RightMost).global_position.x
	
func get_bounded_x():
	"""
	Get X value for camera
	Bounded by minX and maxX if stopAtEdge is set
	RETURNS: bounded x value
	"""	
	var value = obj.global_position.x
	if stopAtEdge:
		value = clamp(value, minX, maxX)
	return value

func _process(_delta):
	"""
	Interpolate between x (and y value) of the camera
	"""
	var targetX = get_bounded_x()
	if global_position.x != targetX:
		tween.interpolate_property(self, "global_position:x", 
			global_position.x, targetX, 0.2, 
			Tween.TRANS_LINEAR, Tween.EASE_OUT_IN
		)
		tween.start()
