extends Control

export(PackedScene) var gameScene = null

onready var PlayButton = $Buttons/PlayButton
onready var CreditsButton = $Buttons/CreditsButton


func _on_PlayButton_pressed():
		
	print("Play and switch scene")
	if gameScene:
		PlayButton.disabled = true
		CreditsButton.disabled = true
		self.visible = false
		get_tree().change_scene_to(gameScene)
		queue_free()


func _on_CreditsButton_pressed():
	print("Credits and switch scene")
	pass
