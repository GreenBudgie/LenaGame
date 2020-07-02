extends KinematicBody2D

const ACCELERATION = 50
const SPEED = 400
const MAX_ROTATION = deg2rad(5)
var controllable = true
var moveVector = Vector2.ZERO

onready var sprite = $Sprite

func _physics_process(delta):
	if controllable:
		var xMove = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		var yMove = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		var vector = Vector2(xMove * SPEED, yMove * SPEED)
		vector.normalized()
		if vector != Vector2.ZERO:
			moveVector = moveVector.move_toward(vector, ACCELERATION)
			if moveVector.x != 0:
				if moveVector.x < 0: 
					sprite.flip_v = true
				else:
					sprite.flip_v = false
		else:
			moveVector = moveVector.move_toward(Vector2.ZERO, ACCELERATION)
		moveVector = move_and_slide(moveVector)
		var rotationModifier = moveVector.y / SPEED * MAX_ROTATION
		if sprite.flip_v: rotationModifier = -rotationModifier
		sprite.rotation = rotationModifier + PI / 2
