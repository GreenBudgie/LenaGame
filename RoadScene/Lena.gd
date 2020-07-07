extends Area2D

enum Pos {TOP = 120, MIDDLE = 360, BOTTOM = 600}

var currentPos = Pos.MIDDLE
var controllable = true

func _ready():
	pass
	
func up():
	var towards = Pos.TOP if currentPos == Pos.MIDDLE else (Pos.MIDDLE if currentPos == Pos.BOTTOM else null)
	if towards != null:
		move(towards)
	
func down():
	var towards = Pos.BOTTOM if currentPos == Pos.MIDDLE else (Pos.MIDDLE if currentPos == Pos.TOP else null)
	if towards != null:
		move(towards)
	
func move(towards):
	$Tween.interpolate_property(self,
				"position:y",
				position.y,
				towards,
				0.2,
				Tween.TRANS_SINE,
				Tween.EASE_IN_OUT)
	$Tween.start()
	$MoveSound.play()
	currentPos = towards
	
func _process(delta):
	if controllable:
		if Input.is_action_just_pressed("move_up"):
			up()
		if Input.is_action_just_pressed("move_down"):
			down()
