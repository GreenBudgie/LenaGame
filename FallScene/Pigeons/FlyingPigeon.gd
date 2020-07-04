extends Area2D

const MAX_ANGLE = 45
var direction
var changingDirection
var speed
var acceleration

func _ready():
	randomize()
	direction = rand_range(-90 - MAX_ANGLE, -90 + MAX_ANGLE)
	changingDirection = rand_range(-0.5, 0.5)
	speed = rand_range(80 / 60.0, 120 / 60.0)
	acceleration = rand_range(3 / 60.0, 5 / 60.0)
	position.x = rand_range(250, ProjectSettings.get("display/window/size/width") - 250)
	position.y = ProjectSettings.get("display/window/size/height") + 20

func calculateCollision():
	var fallScene = get_parent()
	var lena = fallScene.get_node("Lena")
	if lena != null:
		if overlaps_body(lena):
			fallScene.obstacleCollide()
			queue_free()

func _physics_process(delta):
	speed += acceleration
	direction = clamp(direction + changingDirection, -90 - MAX_ANGLE, -90 + MAX_ANGLE)
	position.x += cos(deg2rad(direction)) * speed
	position.y += sin(deg2rad(direction)) * speed
	self.calculateCollision()
	if position.y < -50:
		queue_free()
