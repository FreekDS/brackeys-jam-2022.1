extends Control

export(PackedScene) var gameScene = null

onready var PlayButton = $Menu/Buttons/PlayButton
onready var CreditsButton = $Menu/Buttons/CreditsButton
onready var MyTween = $Tween

onready var MenuNode = $Menu
onready var CreditsNode = $Credits


func _on_PlayButton_pressed():
	if gameScene:
		PlayButton.disabled = true
		CreditsButton.disabled = true
		self.visible = false
		var _n = get_tree().change_scene_to(gameScene)
		queue_free()


func _on_CreditsButton_pressed():
	MyTween.interpolate_property(
		MenuNode, "rect_position",
		MenuNode.rect_position, Vector2(-2000, 0),
		0.2
	)
	MyTween.interpolate_property(
		CreditsNode, "rect_position",
		CreditsNode.rect_position, Vector2.ZERO,
		0.2
	)
	MyTween.start()


func _on_Back_pressed():
	MyTween.interpolate_property(
		MenuNode, "rect_position",
		MenuNode.rect_position, Vector2.ZERO,
		0.2
	)
	MyTween.interpolate_property(
		CreditsNode, "rect_position",
		CreditsNode.rect_position, Vector2(2000, 0),
		0.2
	)
	MyTween.start()
