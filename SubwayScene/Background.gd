extends Sprite

func _process(delta):
	var width = texture.get_width()
	position.x += get_parent().SPEED * delta
	if position.x >= Globals.SCREEN_WIDTH:
		position.x -= width
