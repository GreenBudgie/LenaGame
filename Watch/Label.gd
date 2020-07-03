extends Label

func _ready():
	text = TimeHolder.getTimeRemainingLabel()
	
func _process(delta):
	text = TimeHolder.getTimeRemainingLabel()
