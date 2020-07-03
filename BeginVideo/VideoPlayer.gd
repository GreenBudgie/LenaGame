extends VideoPlayer

func _ready():
	connect("finished", self, "onFinish")

func onFinish():
	get_tree().change_scene("res://FallScene/FallScene.tscn")
