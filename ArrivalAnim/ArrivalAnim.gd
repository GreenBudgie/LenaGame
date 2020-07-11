extends Node2D

func _ready():
	$AnimationPlayer.play("arrival")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://GoodEnding/GoodEnding.tscn")
