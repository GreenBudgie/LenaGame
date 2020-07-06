extends Area2D

const positions = [120, 360, 600]

func _ready():
	pass

func _process(delta):
	position.x += speed * delta
	speed += acceleration * delta
	if position.x > Globals.SCREEN_WIDTH + 100:
		queue_free()
