extends Node2D


export(NodePath) var PlayerPath = null
export(NodePath) var InsanityLayerPath = null
onready var Player = get_node(PlayerPath) as KinematicBody2D
onready var InsanityLayer = get_node(InsanityLayerPath) as Control

export(NodePath) var OtherInteractablesPath = null
var OtherInteractables = null

func _ready():
	if not PlayerPath or not Player:
		printerr("please specify player")
	if not InsanityLayerPath or not InsanityLayer:
		printerr("please specify insanity layer")
	
	if OtherInteractablesPath:
		OtherInteractables = get_node(OtherInteractablesPath)

	_ready_impl(self)
	if OtherInteractables:
		_ready_impl(OtherInteractables)

#	for c in get_children():
#		Player.connect("interact", c, "interact")
#		c.connect("action_message", Player, "say_something")
#		c.connect("action_message", self, "pause_interaction")
#		c.connect("action_insanity", InsanityLayer, "trigger")
#		c.connect("action_insanity", self, "pause_interaction")
#		c.connect("action_telephone", self, "pause_interaction")
#		c.connect("on_interact", self, "pause_interaction")
#		c.connect("resume", self, "unpause_interaction")
#
## warning-ignore:return_value_discarded
#		StateManager.connect("transitioned_to", c, "_on_gameState_change")

	yield(get_tree(), "idle_frame")
	StateManager.notify()

func _ready_impl(obj):
	for c in obj.get_children():
		Player.connect("interact", c, "interact")
		c.connect("action_message", Player, "say_something")
		c.connect("action_message", self, "pause_interaction")
		c.connect("action_insanity", InsanityLayer, "trigger")
		c.connect("action_insanity", self, "pause_interaction")
		c.connect("action_telephone", self, "pause_interaction")
		c.connect("on_interact", self, "pause_interaction")
		c.connect("resume", self, "unpause_interaction")
# warning-ignore:return_value_discarded
		StateManager.connect("transitioned_to", c, "_on_gameState_change")


func _process(_delta):
	for n in get_children():
		n.check_in_range(Player.global_position)
	if OtherInteractables:
		for n in OtherInteractables.get_children():
			n.check_in_range(Player.global_position)


func pause_interaction(_t=null, _o=null):
	for c in get_children():
		c.pause()
	if OtherInteractables:
		for c in OtherInteractables.get_children():
			c.pause()

func unpause_interaction():
	for c in get_children():
		c.unpause()
	if OtherInteractables:
		for c in OtherInteractables.get_children():
			c.unpause()
