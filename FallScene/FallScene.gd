extends Node2D

const BACK_Y_START = -440
const BACK_Y_END = -2296

var flying = false
var flyProgress: float = 0

func _ready():
	$LenaAnimation.connect("animation_finished", self, "startPlaying")
	$LenaAnimation.play("window_fall")
	
func startPlaying(animation):
	if animation == "window_fall":
		flying = true
		TimeHolder.startCounting()
		$BackgroundWind.play()
		$Wind.visible = true
		$Lena.enableControls()
		$PigeonSpawner.startSpawning()

func fallInTrash():
	flying = false
	$Lena.disableControls()
	$BackgroundWind.stop()
	$PigeonSpawner.stopSpawning()

func obstacleCollide():
	$LenaAnimation.play("obstacle_collide")

func _process(delta):
	if flying:
		if(flyProgress >= 1):
			fallInTrash()
		else:
			if $LenaAnimation.is_playing() and $LenaAnimation.current_animation == "obstacle_collide":
				flyProgress -= 0.000032
			else:
				flyProgress += 0.000016
			$HouseBackground.position.y = BACK_Y_START + (flyProgress * (BACK_Y_END - BACK_Y_START))
