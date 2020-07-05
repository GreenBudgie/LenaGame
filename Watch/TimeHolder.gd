extends Timer

signal timeOff()

const START_TIME = 5 * 60

var timeRemaining = START_TIME

func _ready():
	connect("timeout", self, "count")

func getTimeRemaining():
	return timeRemaining
	
func pauseCounting():
	self.paused = true
	
func resumeCounting():
	self.paused = false
	
func getTimeRemainingLabel():
	var seconds = timeRemaining % 60
	var minutes = timeRemaining / 60
	return str(minutes, ":", str(seconds).pad_zeros(2))

func startCounting():
	start(1)

func count():
	timeRemaining -= 1
	if(timeRemaining <= 0):
		emit_signal("timeOff")
