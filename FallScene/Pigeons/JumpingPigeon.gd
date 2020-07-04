extends RigidBody2D

var HEIGHT = ProjectSettings.get("display/window/size/height")
var WIDTH = ProjectSettings.get("display/window/size/width")

var direction
var facingRight = false

var delay = 0

func _ready():
	randomize()
	if randf() > 0.5:
		position.x = WIDTH + 40
	else:
		position.x = -40
		$Sprite.scale.x = -$Sprite.scale.x
		$CollisionPolygon2D.scale.x = -$CollisionPolygon2D.scale.x
		facingRight = true
	position.y = rand_range(HEIGHT - 200, HEIGHT)
	jump()
	connect("body_entered", self, "collide")
	
func collide(body):
	if body == get_parent().get_node("Lena"):
		get_parent().obstacleCollide()
		queue_free()

func jump():
	if delay <= 0:
		direction = rand_range(230, 260)
		var vel = rand_range(450, 650)
		var right = 1
		if facingRight: right = -1
		var force = Vector2(cos(deg2rad(direction)) * vel * right, sin(deg2rad(direction)) * vel)
		linear_velocity = force
		delay = 10

func _physics_process(delta):
	if delay > 0: delay -= 1
	if position.y > HEIGHT:
		jump()
	if facingRight and position.x > WIDTH + 50:
		queue_free()
	if !facingRight and position.x < -50:
		queue_free()
