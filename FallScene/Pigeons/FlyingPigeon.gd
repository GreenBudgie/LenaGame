extends Area2D

const MAX_ANGLE = 60
var direction
var changingDirection
var speed
var acceleration

func _ready():
	randomize()
	direction = rand_range(-90 - MAX_ANGLE, -90 + MAX_ANGLE)
	changingDirection = rand_range(-1, 1)
	speed = rand_range(1, 2)
	acceleration = rand_range(0.05, 0.1)
	position.x = rand_range(50, ProjectSettings.get("display/window/size/width") - 50)
	position.y = ProjectSettings.get("display/window/size/height") + 20

func calculateCollision():
	var fallScene = get_parent()
	var lena = fallScene.get_node("Lena")
	if lena != null:
		if overlaps_body(lena):
			fallScene.obstacleCollide()
			queue_free()

func _process(delta):
	speed += acceleration
	direction = clamp(direction + changingDirection, -90 - MAX_ANGLE, -90 + MAX_ANGLE)
	position.x += cos(deg2rad(direction)) * speed
	position.y += sin(deg2rad(direction)) * speed
	self.calculateCollision()
	if position.y < -50:
		queue_free()
