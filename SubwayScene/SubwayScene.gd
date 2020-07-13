extends Node2D

const START_SPEED = 150
const END_SPEED = 500

var currentSpeed = START_SPEED
var running = false
var progress = 0.0

var tween = Tween.new()

onready var grannyScript = preload("res://SubwayScene/Granny.gd")
onready var childScript = preload("res://SubwayScene/Children.gd")

func _ready():
	add_child(tween)
	$AnimationPlayer.play("start")
	$AnimationPlayer.connect("animation_finished", self, "animationFinished")

func animationFinished(animation):
	if animation == "start":
		startRunning()

func startRunning():
	$Lena.controllable = true
	$Lena.applyPhysics = true
	TimeHolder.resumeCounting()
	running = true
	$PeopleSpawner.startSpawning()
	$Lena/Helpers.show()
	
func stopRunning():
	$Lena.controllable = false
	TimeHolder.pauseCounting()
	running = false
	$PeopleSpawner.stopSpawning()
	tween.interpolate_property($Ambient, "volume_db", $Ambient.volume_db, -80, 2)
	tween.interpolate_property($Background, "position:x", $Background.position.x, $Background.position.x + 250, 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.interpolate_property($Wagon, "position:x", $Wagon.position.x, 0, 2, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	#Delay 2
	tween.interpolate_property($Lena, "position:x", $Lena.position.x, 800, 2, Tween.TRANS_EXPO, Tween.EASE_OUT, 2)
	tween.interpolate_property($Lena, "position:y", $Lena.position.y, 475, 2, Tween.TRANS_EXPO, Tween.EASE_OUT, 2)
	tween.interpolate_property($Lena, "scale", $Lena.scale, $Lena.scale / 1.5, 2, Tween.TRANS_EXPO, Tween.EASE_OUT, 2)
	tween.interpolate_property($Lena, "rotation", $Lena.rotation, $Lena.rotation + PI * 4, 2, Tween.TRANS_EXPO, Tween.EASE_OUT, 2)
	tween.interpolate_property($Lena, "modulate:a", 1, 0, 1.5, Tween.TRANS_CUBIC, Tween.EASE_IN, 2.5)
	tween.start()
	
	$TrainArrive.play()
	yield(get_tree().create_timer(2), "timeout")
	$LenaFly.play()
	yield(get_tree().create_timer(3), "timeout")
	get_tree().change_scene("res://ArrivalAnim/ArrivalAnim.tscn")

func _process(delta):
	if progress >= 1 and running:
		stopRunning()
	currentSpeed = START_SPEED + (END_SPEED - START_SPEED) * progress
	if running:
		progress += 0.015 * delta

func collide():
	if running:
		tween.interpolate_property(	self, "progress", progress, max(progress - 0.018, 0), 1, 
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
