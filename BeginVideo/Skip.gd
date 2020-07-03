extends Button

func _pressed():
	var videoPlayer = get_parent().get_node("VideoPlayer")
	videoPlayer.emit_signal("finished")
	videoPlayer.stop()
