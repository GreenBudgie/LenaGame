extends Area2D

const ANGLE_DELTA = 0.0003
const MIN_DIST = 100

var acceleration
var startSpeed
var speed
var angle = 0

onready var lena = get_parent().get_node("Lena")

func _ready():
	randomize()
	acceleration = rand_range(300, 400)
	startSpeed = rand_range(200, 500)
	speed = startSpeed

func _process(delta):
	if lena != null:
		var lenaAngle = position.angle_to_point(lena.position) + PI
		if lenaAngle > PI: lenaAngle = lenaAngle - 2 * PI
		if lena.position.x - position.x > MIN_DIST:
			angle = move_toward(angle, lenaAngle, ANGLE_DELTA)
	rotation = angle
	speed += acceleration * delta
	position.x += cos(angle) * speed * delta
	position.y += sin(angle) * speed * delta
	if position.x > Globals.SCREEN_WIDTH + 100:
		queue_free()
