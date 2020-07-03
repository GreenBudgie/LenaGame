extends VideoPlayer

func _ready():
	connect("finished", self, "finished")

func finished():
	SceneChanger.changeScene("res://FallScene/FallScene.tscn")
