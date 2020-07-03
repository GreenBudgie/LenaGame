extends Button

func _pressed():
	var videoPlayer = get_parent().get_node("VideoPlayer")
	get_parent().get_node("AudioFader").play("audio_fade")
	videoPlayer.emit_signal("finished")
