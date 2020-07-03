extends Node2D

const FLYING_PIGEON = preload("Pigeons/FlyingPigeon.tscn")
const MAX_DELAY = 3000
const MIN_DELAY = 2000
const DECREASE_VAL = 100

enum STATE {
	WINDOW_FALL,
	PLAYING,
	TRASH_FALLING
}

var state = STATE.WINDOW_FALL
var pigeonAddDelay = MAX_DELAY
var prevDelay = MAX_DELAY

func _ready():
	$LenaAnimation.connect("animation_finished", self, "startPlaying")
	$LenaAnimation.play("window_fall")
	
func startPlaying():
	print(1)
	$Lena.enableControls()

func addPigeon():
	add_child(FLYING_PIGEON.instance())

func _process(delta):
	pigeonAddDelay -= 1
	if pigeonAddDelay <= 0:
		addPigeon()
		prevDelay = max(prevDelay - DECREASE_VAL, MIN_DELAY)
		pigeonAddDelay = prevDelay
