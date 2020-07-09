extends Node2D

const START_SPEED = 150
const END_SPEED = 500

var currentSpeed = START_SPEED
var running = true
var progress = 0.0

var tween = Tween.new()

onready var grannyScript = preload("res://SubwayScene/Granny.gd")
onready var childScript = preload("res://SubwayScene/Children.gd")

func _ready():
	add_child(tween)
	startRunning()

func startRunning():
	$Lena.controllable = true
	TimeHolder.resumeCounting()
	running = true
	$PeopleSpawner.startSpawning()
	
func stopRunning():
	$Lena.controllable = false
	TimeHolder.pauseCounting()
	running = false
	$PeopleSpawner.stopSpawning()

func _process(delta):
	if progress >= 1:
		stopRunning()
	currentSpeed = START_SPEED + (END_SPEED - START_SPEED) * progress
	if running:
		progress += 0.018 * delta

func collide():
	if running:
		tween.interpolate_property(	self, "progress", progress, max(progress - 0.02, 0), 1, 
									Tween.TRANS_CUBIC, Tween.EASE_OUT)
		tween.interpolate_property(	$Background, "position:x", $Background.position.x, $Background.position.x - currentSpeed,
									1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		for child in get_children():
			if child.get_script() == grannyScript or child.get_script() == childScript:
				tween.interpolate_property(	child, "position:x", child.position.x, child.position.x - currentSpeed,
									1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		tween.start()
		$PeopleSpawner.paused = true
		yield(tween, "tween_completed")
		$PeopleSpawner.paused = false
		$PeopleSpawner.start($PeopleSpawner.time_left + 1)
