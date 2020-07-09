extends "res://SubwayScene/Collidable.gd"

const GRAVITY = 0.12
const JUMP_FORCE = 10

onready var startY = position.y

var jumping = false
var tween = Tween.new()
var motionY = 0

func _ready():
	add_child(tween)
	$JumpTimer.connect("timeout", self, "jump")
	randomize()
	$JumpTimer.start(rand_range(0.1, 3.5))
	var sprites = $Sprites
	var sprite = sprites.get_children()[randi() % sprites.get_child_count()]
	for child in sprites.get_children():
		if sprite != child: child.visible = false

func onCollide():
	$JumpTimer.stop()
	match status:
		CollideStatus.CRUSH:
			$Crush.play()
			tween.interpolate_property(self, "rotation", rotation, rotation - PI * 4.5, 2, Tween.TRANS_CUBIC, Tween.EASE_OUT)
			tween.interpolate_property(self, "position:y", position.y, 650, 2, Tween.TRANS_BACK, Tween.EASE_OUT)
		CollideStatus.JUMP:
			$JumpOnTop.play()
			tween.interpolate_property(self, "rotation", rotation, rotation + PI / 2, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
			tween.interpolate_property(self, "position:y", position.y, 650, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		CollideStatus.PUSH:
			$Push.play()
			tween.interpolate_property(self, "rotation", rotation, rotation + PI / 2, 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
			tween.interpolate_property(self, "position:x", position.x, position.x + 400, 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
			tween.interpolate_property(self, "position:y", position.y, 650, 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()

func jump():
	if !jumping:
		$Jump.play()
		$JumpTimer.start(rand_range(0.1, 3.5))
		jumping = true
		motionY = -JUMP_FORCE

func _physics_process(delta):
	if status == CollideStatus.UNKNOWN:
		if jumping:
			motionY += GRAVITY
			position.y += motionY
		if jumping and position.y > startY: #Landing
			jumping = false
			position.y = startY

func _process(delta):
	checkCollisions()
	var speed = get_parent().currentSpeed
	position.x += speed * delta
	if position.x > Globals.SCREEN_WIDTH + 200:
		queue_free()
