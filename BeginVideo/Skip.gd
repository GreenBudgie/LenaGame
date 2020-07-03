extends Button

func _pressed():
	var videoPlayer = get_parent().get_node("VideoPlayer")
	videoPlayer.volume = 0
	videoPlayer.emit_signal("finished")
