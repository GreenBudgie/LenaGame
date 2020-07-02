extends Node2D

const FLYING_PIGEON = preload("FlyingPigeon.tscn")
const MAX_DELAY = 3000
const MIN_DELAY = 2000
const DECREASE_VAL = 100

var pigeonAddDelay = MAX_DELAY
var prevDelay = MAX_DELAY

func addPigeon():
	add_child(FLYING_PIGEON.instance())

func _process(delta):
	pigeonAddDelay -= 1
	if pigeonAddDelay <= 0:
		addPigeon()
		prevDelay = max(prevDelay - DECREASE_VAL, MIN_DELAY)
		pigeonAddDelay = prevDelay
