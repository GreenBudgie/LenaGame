extends Sprite

func _process(delta):
	var width = texture.get_width()
	if !get_node("../Lena").crushed and get_parent().running:
		position.x += get_parent().currentSpeed * delta
	if position.x >= Globals.SCREEN_WIDTH:
		position.x -= width
