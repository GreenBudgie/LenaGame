extends Node2D

func _ready():
	$AnimationPlayer.play("fall")
	yield($AnimationPlayer, "animation_finished")
	print("NEXT")
