extends Node2D

func _ready():
	TimeHolder.zero = true
	$AnimationPlayer.play("animation")
	yield($AnimationPlayer, "animation_finished")
	TimeHolder.reset()
	get_tree().change_scene("res://Menu/Menu.tscn")
