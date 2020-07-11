extends Node2D

func _ready():
	$AnimationPlayer.play("ending")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://Menu/Menu.tscn")
