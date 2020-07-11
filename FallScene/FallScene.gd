extends Node2D

const BACK_Y_START = -440
const BACK_Y_END = -2100
const BACK_Y_TRASH = -2300

var flying = false
var flyProgress: float = 0.0
var collided = false

func _ready():
	$LenaAnimation.connect("animation_finished", self, "startPlaying")
	$LenaAnimation.play("window_fall")
	
func startPlaying(animation):
	if animation == "window_fall":
		flying = true
		TimeHolder.startCounting()
		get_node("Lena/Helpers").show()
		$BackgroundWind.play()
		$Wind.visible = true
		$Lena.enableControls()
		$PigeonSpawner.startSpawning()
	if animation == "trash_fall":
		get_tree().change_scene("res://RoadScene/RoadScene.tscn")

func fallInTrash():
	flying = false
	TimeHolder.pauseCounting()
	$Lena.sprite.flip_v = false
	$Lena.disableControls()
	$BackgroundWind.stop()
	$PigeonSpawner.stopSpawning()
	$Tween.remove_all()
	$Wind.visible = false
	$Tween.interpolate_property($HouseBackground,
			"position:y",
			BACK_Y_END,
			BACK_Y_TRASH,
			1,
			Tween.TRANS_CUBIC,
			Tween.EASE_IN)
	$Tween.interpolate_property($Trash,
			"position:y",
			$Trash.position.y,
			$Trash.position.y - 300,
			1,
			Tween.TRANS_CUBIC,
			Tween.EASE_IN)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	$Tween.remove_all()
	$Tween.interpolate_property($Lena,
			"position",
			$Lena.position,
			Vector2($Trash.position.x, 50),
			1,
			Tween.TRANS_CUBIC,
			Tween.EASE_IN)
	$Tween.interpolate_property($Lena,
			"position",
			Vector2($Trash.position.x, 50),
			$Trash.position,
			1,
			Tween.TRANS_CUBIC,
			Tween.EASE_IN,
			1)
	$Tween.interpolate_property($Lena,
			"scale",
			$Lena.scale,
			$Lena.scale / 1.5,
			2,
			Tween.TRANS_CUBIC,
			Tween.EASE_IN)
	$Tween.interpolate_property($Lena,
			"rotation",
			$Lena.rotation,
			$Lena.rotation + PI * 6,
			2,
			Tween.TRANS_CUBIC,
			Tween.EASE_IN)
	$Tween.start()
	$LenaAnimation.play("trash_fall")

func obstacleCollide():
	if flying:
		collided = true
		$LenaAnimation.play("white_screen")
		$CollideSound.play()
		$Lena.onCollide()
		collided = false

func _process(delta):
	if flying:
		if(flyProgress >= 1):
			fallInTrash()
		else:
			if !collided:
				flyProgress += 0.012 * delta
			$HouseBackground.position.y = BACK_Y_START + (flyProgress * (BACK_Y_END - BACK_Y_START))
