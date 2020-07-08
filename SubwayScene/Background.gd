extends Sprite

const BACK_SPEED = 400

func _process(delta):
	var width = texture.get_width()
	position.x += BACK_SPEED * delta
	if position.x >= Globals.SCREEN_WIDTH:
		position.x -= width
