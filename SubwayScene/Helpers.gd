extends Position2D

onready var LINKS = {
	"move_left": $Left,
	"move_right": $Right,
	"move_up": $Up,
	}

var fading = false

func _process(delta):
	if get_parent().controllable:
		for action in LINKS.keys():
			if Input.is_action_just_pressed(action): press(LINKS.get(action))
			if Input.is_action_just_released(action): release(LINKS.get(action))

func show():
	$FadingAnimation.remove_all()
	for helper in get_children():
		if helper.get_class() == "Sprite":
			$FadingAnimation.interpolate_property(helper, "modulate:a", 0, 1, 1)
	$FadingAnimation.start()

func press(helper: Node2D):
	helper.modulate = Color(0.8, 0.8, 0.8, helper.modulate.a)
	fade()
	
func release(helper):
	helper.modulate = Color(1, 1, 1, helper.modulate.a)
	
func fade():
	if !fading:
		fading = true
		$FadingAnimation.remove_all()
		for helper in get_children():
			if helper.get_class() == "Sprite":
				$FadingAnimation.interpolate_property(helper, "modulate:a", 1, 0, 3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 1)
		$FadingAnimation.start()
