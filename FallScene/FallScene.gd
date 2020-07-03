extends Node2D

const FLYING_PIGEON = preload("Pigeons/FlyingPigeon.tscn")
const BACK_Y_START = -440
const BACK_Y_END = -2296

var flying = false
var flyProgress: float = 0

func _ready():
	$LenaAnimation.connect("animation_finished", self, "startPlaying")
	$LenaAnimation.play("window_fall")
	
func startPlaying(_ignored):
	flying = true
	$BackgroundWind.play()
	$Wind.visible = true
	$Lena.enableControls()

func addPigeon():
	add_child(FLYING_PIGEON.instance())

func _process(delta):
	if flying:
		if(flyProgress >= 1):
			$BackgroundWind.stop()
		else:
			flyProgress += 0.000016
			$HouseBackground.position.y = BACK_Y_START + (flyProgress * (BACK_Y_END - BACK_Y_START))
