extends KinematicBody2D

const TARGET_FPS = 60
const ACCELERATION = 32
const MAX_SPEED = 256
const FRICTION = 10
const AIR_RESISTANCE = 10
const GRAVITY = 20
const JUMP_FORCE = 920

var motion = Vector2.ZERO
var fall = false

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

func onCollide(obj):
	if obj.status == obj.CollideStatus.JUMP:
		motion.y = -JUMP_FORCE / 2

func _physics_process(delta):
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if x_input != 0:
		if is_on_floor():
			animationPlayer.play("run")
		motion.x += x_input * ACCELERATION * delta * TARGET_FPS
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = x_input > 0
	else:
		if is_on_floor():
			animationPlayer.play("idle")
		
	motion.y += GRAVITY * delta * TARGET_FPS
	if is_on_floor():
		fall = false
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION * delta)
		if Input.is_action_just_pressed("move_up"):
			animationPlayer.play("jump")
			motion.y = -JUMP_FORCE
	else:
		if !fall and motion.y > 0:
			animationPlayer.play_backwards("jump")
			fall = true
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE * delta)
	
	motion = move_and_slide(motion, Vector2.UP)
