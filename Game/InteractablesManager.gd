extends Node2D


export(NodePath) var PlayerPath = null
export(NodePath) var InsanityLayerPath = null
onready var Player = get_node(PlayerPath) as KinematicBody2D
onready var InsanityLayer = get_node(InsanityLayerPath) as Control

func _ready():
	if not PlayerPath or not Player:
		printerr("please specify player")
	if not InsanityLayerPath or not InsanityLayer:
		printerr("please specify insanity layer")

	for c in get_children():
		Player.connect("interact", c, "interact")
		c.connect("action_message", Player, "say_something")
		c.connect("action_message", self, "pause_interaction")
		c.connect("action_insanity", InsanityLayer, "trigger")
		c.connect("action_insanity", self, "pause_interaction")
		c.connect("action_telephone", self, "pause_interaction")
		c.connect("resume", self, "unpause_interaction")
		
		StateManager.connect("transitioned_to", c, "_on_gameState_change")

	yield(get_tree(), "idle_frame")
	StateManager.notify()

func _process(_delta):
	for n in get_children():
		n.check_in_range(Player.global_position)

func pause_interaction(_t=null, _o=null):
	for c in get_children():
		if not c.is_paused:
			c.prev_enabled = c.enabled
			c.enabled = false
			c.is_paused = true

func unpause_interaction():
	for c in get_children():
		if c.is_paused:
			c.enabled = c.prev_enabled
			c.is_paused = false
