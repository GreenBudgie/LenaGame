extends Button

func _pressed():
	SceneChanger.changeScene("res://BeginVideo/Video.tscn")
	$ClickSound.play()
