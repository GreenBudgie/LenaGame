extends KinematicBody2D

const FRICTION = 150

var purity = 0.0
var direction = 0
var speed = 0
var vector = Vector2.ZERO

func _ready():
	$Sprite.frame = randi() % 3

func wash():
	if speed == 0:
		speed = rand_range(200, 300)
		direction = rand_range(0, 360)
	else:
		speed += rand_range(150, 200)
		direction += rand_range(-45, 45)
	purity += rand_range(0.25, 0.4)
	modulate.a = clamp(1.25 - purity, 0.35, 1)
	if purity >= 1.0:
		disappear()

func _physics_process(delta):
	if speed != 0:
		if position.x < 0 or position.x > 1280 * 4:
			direction = 180 - direction
		if position.y < 200 or position.y > 720:
			direction = 180 - direction
		var moveVector = Vector2(cos(deg2rad(direction)) * speed, sin(deg2rad(direction)) * speed)
		vector = move_and_slide(moveVector)
		speed = move_toward(speed, 0, FRICTION * delta)

func disappear():
	get_parent().clean(self)
	queue_free()
