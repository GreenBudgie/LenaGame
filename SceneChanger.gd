extends CanvasLayer

signal sceneChanged()

onready var animation = $AnimationPlayer

#Changes a scene with 1 second of a black-fade transition
func changeScene(to, fadeIn = true):
	animation.play("fade")
	yield(animation, "animation_finished")
	get_tree().change_scene(to)
	if fadeIn:
		animation.play_backwards("fade")
		yield(animation, "animation_finished")
	else:
		animation.seek(0, true)
	emit_signal("sceneChanged")
