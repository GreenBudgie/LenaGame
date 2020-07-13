extends TextureButton

var justHovered = false

func _pressed():
	if !SceneChanger.changing:
		$ClickSound.play()
		SceneChanger.changeScene("res://BeginVideo/Video.tscn")

func _process(delta):
	if !SceneChanger.changing:
		if !is_hovered():
			justHovered = false
		if !justHovered and is_hovered():
			justHovered = true
			get_node("../HoverSound").play()
