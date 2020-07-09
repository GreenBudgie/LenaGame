extends Node2D

func _ready():
	$AnimationPlayer.play("fall")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://SubwayScene/SubwayScene.tscn")
