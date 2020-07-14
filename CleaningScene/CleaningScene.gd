extends Node2D

const DIRT_COUNT = 25
const CORRIDOR_WIDTH = 1280 * 4

var DIRT = preload("res://CleaningScene/Dirt.tscn")

var cleanSounds = 	[
					preload("res://CleaningScene/Sound/clean1.wav"),
					preload("res://CleaningScene/Sound/clean2.wav"),
					preload("res://CleaningScene/Sound/clean3.wav"),
					]

var dirtScript = preload("res://CleaningScene/Dirt.gd")
var running = true
var currentSpeed = 300

func _ready():
	randomize()
	placeDirt()
	$AnimationPlayer.play("start")
	yield($AnimationPlayer, "animation_finished")
	$Lena.controllable = true
	$Lena.animWalking = false
	TimeHolder.resumeCounting()
	$Lena/Space.show()

func stop():
	$Lena/Camera2D.clear_current()
	$Lena.controllable = false
	TimeHolder.stopCounting()
	yield(get_tree().create_timer(0.5), "timeout")
	$WhipSound.play()
	$Tween.interpolate_property($Lena/Sprite/Mop, "position:y", $Lena/Sprite/Mop.position.y, $Lena/Sprite/Mop.position.y - 720 * 2,
								1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.interpolate_property($Lena/Sprite/Mop, "rotation_degrees", 0, 360,
								1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	#Delay 1
	$Tween.interpolate_property($Lena, "position:x", $Lena.position.x, $Lena.position.x + 1280,
								1, Tween.TRANS_CUBIC, Tween.EASE_OUT, 1)
	$Tween.interpolate_property($Lena, "position:y", $Lena.position.y, $Lena.position.y - 100,
								1, Tween.TRANS_CUBIC, Tween.EASE_OUT, 1)
	$Tween.start()
	yield(get_tree().create_timer(1), "timeout")
	$WhipSound.play()
	yield($Tween, "tween_all_completed")
	$Lena/Camera2D.make_current()
	get_tree().change_scene("res://GoodEnding/GoodEnding.tscn")

func clean(drt):
	$CleanAudio.stream = cleanSounds[randi() % 3]
	$CleanAudio.play()
	var dirtCount = 0
	for dirt in get_children():
			if dirt.get_script() == dirtScript:
				dirtCount += 1
	if dirtCount <= 1: stop()

func placeDirt():
	for i in range(0, DIRT_COUNT):
		var posX = rand_range(180, CORRIDOR_WIDTH - 180)
		var posY = rand_range(300, 720 - 180)
		var dirt = DIRT.instance()
		dirt.position.x = posX
		dirt.position.y = posY
		add_child(dirt)

func _process(delta):
	$Watch.position.x = $Lena/Camera2D.get_camera_screen_center().x - 560
