extends Sprite

const BACK_WIDTH = 1280
const BACK_SPEED = 400

var SCREEN_WIDTH = ProjectSettings.get("display/window/size/width")

func _process(delta):
	position.x += BACK_SPEED * delta
	if position.x >= SCREEN_WIDTH:
		position.x -= BACK_WIDTH
	
