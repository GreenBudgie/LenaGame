extends Sprite

var fading = false

func _process(delta):
	if get_parent().controllable:
		if Input.is_action_just_pressed("wash"): press()
		if Input.is_action_just_released("wash"): release()

func show():
	$FadingAnimation.remove_all()
	$FadingAnimation.interpolate_property(self, "modulate:a", 0, 1, 1)
	$FadingAnimation.start()

func press():
	modulate = Color(0.8, 0.8, 0.8, modulate.a)
	fade()
	
func release():
	modulate = Color(1, 1, 1, modulate.a)
	
func fade():
	if !fading:
		fading = true
		$FadingAnimation.remove_all()
		$FadingAnimation.interpolate_property(self, "modulate:a", 1, 0, 3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 1)
		$FadingAnimation.start()
