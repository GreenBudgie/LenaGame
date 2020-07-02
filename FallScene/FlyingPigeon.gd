extends KinematicBody2D

const MAX_ANGLE = 60
var direction
var changingDirection
var speed
var acceleration

func _ready():
	randomize()
	direction = rand_range(-90 - MAX_ANGLE, -90 + MAX_ANGLE)
	changingDirection = rand_range(-1, 1)
	speed = rand_range(80, 120)
	acceleration = rand_range(3, 5)
	position.x = rand_range(0, ProjectSettings.get("display/window/size/width"))
	position.y = ProjectSettings.get("display/window/size/height") + 20

func _physics_process(delta):
	speed += acceleration
	direction = clamp(direction + changingDirection, -90 - MAX_ANGLE, -90 + MAX_ANGLE)
	var vector = move_and_slide(Vector2(cos(deg2rad(direction)) * speed, sin(deg2rad(direction)) * speed))
	if position.y < -50:
		queue_free()
