extends Node2D


export(NodePath) var PlayerPath = null
export(NodePath) var InsanityLayerPath = null
onready var Player = get_node(PlayerPath) as KinematicBody2D
onready var InsanityLayer = get_node(InsanityLayerPath) as Control

func _ready():
	if not PlayerPath or not Player:
		printerr("please specify player")
	
	for c in get_children():
		Player.connect("interact", c, "interact")
		c.connect("action_message", Player, "say_something")
		c.connect("action_insanity", InsanityLayer, "trigger")

func _process(_delta):
	for n in get_children():
		n.check_in_range(Player.global_position)
