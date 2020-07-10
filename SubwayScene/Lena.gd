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
var firstFall = true
var controllable = false
var crushed = false
var applyPhysics = false

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

var tween = Tween.new()

var walkSounds = 	[
					preload("res://SubwayScene/Sound/walk1.wav"),
					preload("res://SubwayScene/Sound/walk2.wav"),
					preload("res://SubwayScene/Sound/walk3.wav"),
					preload("res://SubwayScene/Sound/walk4.wav")
					]

func _ready():
	add_child(tween)

func onCollide(obj):
	if get_parent().running:
		if obj.status == obj.CollideStatus.CRUSH:
			controllable = false
			crushed = true
			motion.y = 0
			tween.interpolate_property($Sprite, "rotation", $Sprite.rotation, $Sprite.rotation + 2 * PI, 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
			tween.interpolate_property(	self, "position:x", position.x, min(position.x + get_parent().currentSpeed, 1280), 
										1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
			tween.start()
			yield(tween, "tween_all_completed")
			controllable = true
			crushed = false
		if obj.status == obj.CollideStatus.JUMP:
			motion.y = -JUMP_FORCE / 2

func playWalkSound():
	if !$WalkAudio.playing:
		$WalkAudio.stream = walkSounds[randi() % 4]
		$WalkAudio.play()

func _physics_process(delta):
	if controllable and !crushed and $Sprite.rotation != 0:
		$Sprite.rotation = 0
	
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if !controllable: x_input = 0
	
	if x_input != 0:
		if is_on_floor():
			playWalkSound()
			animationPlayer.play("run")
		motion.x += x_input * ACCELERATION * delta * TARGET_FPS
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = x_input > 0
	else:
		if is_on_floor() and controllable:
			animationPlayer.play("idle")
		
	if applyPhysics:
		motion.y += GRAVITY * delta * TARGET_FPS
	if is_on_floor():
		if fall:
			if firstFall:
				firstFall = false
			else:
				$LandSound.play()
		fall = false
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION * delta)
		if Input.is_action_just_pressed("move_up") and controllable:
			$JumpSound.play()
			animationPlayer.play("jump")
			motion.y = -JUMP_FORCE
	else:
		if !fall and motion.y > 0 and controllable:
			animationPlayer.play_backwards("jump")
			fall = true
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE * delta)
	
	if applyPhysics:
		motion = move_and_slide(motion, Vector2.UP)
	if !applyPhysics or !controllable:
		animationPlayer.play("idle")
