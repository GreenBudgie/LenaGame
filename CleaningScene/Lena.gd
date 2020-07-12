extends KinematicBody2D

const ACCELERATION = 80
const MAX_SPEED = 400
const MOVE_EPSILON = 1

var moveVector = Vector2.ZERO

var washSounds = 	[
					preload("res://CleaningScene/Sound/wash1.wav"),
					preload("res://CleaningScene/Sound/wash2.wav"),
					preload("res://CleaningScene/Sound/wash3.wav"),
					]

var walkSounds = 	[
					preload("res://SubwayScene/Sound/walk1.wav"),
					preload("res://SubwayScene/Sound/walk2.wav"),
					preload("res://SubwayScene/Sound/walk3.wav"),
					preload("res://SubwayScene/Sound/walk4.wav")
					]

var dirtScript = preload("res://CleaningScene/Dirt.gd")

func playWalkSound():
	if !$WalkAudio.playing:
		$WalkAudio.stream = walkSounds[randi() % 4]
		$WalkAudio.play()

func isMoving():
	return abs(moveVector.x) > MOVE_EPSILON or abs(moveVector.y) > MOVE_EPSILON

func wash():
	if !$Tween.is_active():
		$Tween.interpolate_property($Sprite/Mop, "rotation_degrees", 0, -10, 0.1, Tween.TRANS_CUBIC, Tween.EASE_IN)
		$Tween.interpolate_property($Sprite/Mop, "rotation_degrees", -10, 20, 0.2, Tween.TRANS_CUBIC, Tween.EASE_OUT, 0.1)
		$Tween.interpolate_property($Sprite/Mop, "rotation_degrees", 20, 0, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.3)
		$Tween.start()
		$WashAudio.stream = washSounds[randi() % 3]
		$WashAudio.play()
		for dirt in get_parent().get_children():
			if dirt.get_script() == dirtScript:
				if $MopArea.overlaps_area(dirt.get_node("Area2D")):
					dirt.wash()

func _physics_process(delta):
	var xMovement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var yMovement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	var vector = Vector2(xMovement, yMovement)
	vector = vector.normalized()
	moveVector = moveVector.move_toward(vector * MAX_SPEED, ACCELERATION)
	moveVector = move_and_slide(moveVector)
	if isMoving():
		$AnimationPlayer.play("walk")
		playWalkSound()
		if moveVector.x < 0:
			$Sprite.flip_h = false
			$Sprite/Mop.flip_h = false
		else:
			$Sprite.flip_h = true
			$Sprite/Mop.flip_h = true
	else:
		$AnimationPlayer.play("idle")
	if Input.is_action_just_pressed("wash"):
		wash()
