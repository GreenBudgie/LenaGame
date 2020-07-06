extends Area2D

const ANGLE_DELTA = PI / 128

var speed = 300
var angle = 0

onready var lena = get_parent().get_node("Lena")

func _ready():
	pass

func _process(delta):
	var lenaAngle = position.angle_to_point(lena.position)
	move_toward(angle, lenaAngle, ANGLE_DELTA)
	rotation = angle
	position.x += cos(angle) * speed * delta
	position.y += sin(angle) * speed * delta
	if position.x > Globals.SCREEN_WIDTH + 100:
		queue_free()
