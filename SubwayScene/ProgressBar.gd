extends Control

onready var startPos = $Lena.position.x
onready var endPos = $Finish.position.x

func _process(delta):
	$Lena.position.x = startPos + get_parent().progress * (endPos - startPos)
