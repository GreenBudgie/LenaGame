extends Node2D

const DIRT_COUNT = 20
const CORRIDOR_WIDTH = 1280 * 4

var DIRT = preload("res://CleaningScene/Dirt.tscn")

var cleanSounds = 	[
					preload("res://CleaningScene/Sound/clean1.wav"),
					preload("res://CleaningScene/Sound/clean2.wav"),
					preload("res://CleaningScene/Sound/clean3.wav"),
					]

var running = true
var currentSpeed = 300

func _ready():
	randomize()
	placeDirt()

func clean(dirt):
	$CleanAudio.stream = cleanSounds[randi() % 3]
	$CleanAudio.play()

func placeDirt():
	for i in range(0, 20):
		var posX = rand_range(180, CORRIDOR_WIDTH - 180)
		var posY = rand_range(300, 720 - 180)
		var dirt = DIRT.instance()
		dirt.position.x = posX
		dirt.position.y = posY
		add_child(dirt)

func _process(delta):
	pass
