extends "res://Player/Player.gd"

export(NodePath) var PlayerPath = ""
onready var Player = get_node(PlayerPath)

func _ready():
	$Collider.disabled = true
	pass
	
func get_input():
	.get_input()
	return 0

func _process(_delta):
	position = Player.position
