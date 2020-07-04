extends RigidBody2D

const MAX_ANGLE = 30
var HEIGHT = ProjectSettings.get("display/window/size/height")

var jumped = false
var direction
var velocity = 400

func _ready():
	randomize()
	position.x = ProjectSettings.get("display/window/size/width") + 20
	position.y = rand_range(50, HEIGHT - 60)
	jump()

func jump():
	if not jumped:
		jumped = true
		direction = rand_range(250 - MAX_ANGLE, 250 + MAX_ANGLE)
		var force = Vector2(cos(deg2rad(direction)) * velocity, sin(deg2rad(direction)) * velocity)
		applied_force = Vector2.ZERO
		linear_velocity = Vector2.ZERO
		add_central_force(force)
		apply_central_impulse(force)

func _physics_process(delta):
	print(jumped)
	if position.y < HEIGHT - 200:
		jumped = false
	if position.y > HEIGHT - 100:
		jump()
	if position.x < -50:
		queue_free()
