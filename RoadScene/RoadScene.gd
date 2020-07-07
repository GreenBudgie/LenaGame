extends Node2D

var riding = false
var pushedBack = false
var progress = 0.0

onready var pushAnimation = Tween.new()
onready var endAnimation = Tween.new()

func _ready():
	add_child(pushAnimation)
	add_child(endAnimation)
	$AnimationPlayer.play("start")
	$AnimationPlayer.connect("animation_finished", self, "finished")

func finished(animation):
	if animation == "start":
		startRiding()

func pushBack():
	if !pushedBack and riding:
		pushedBack = true
		pushAnimation.interpolate_property(	self, "progress", progress, max(progress - 0.02, 0), 1, 
											Tween.TRANS_CUBIC, Tween.EASE_OUT)
		pushAnimation.interpolate_property(	$Background, "position:x", $Background.position.x,
											$Background.position.x - 50, 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		var lenaSpr = get_node("Lena/Sprite");
		pushAnimation.interpolate_property(	lenaSpr, "rotation", lenaSpr.rotation, lenaSpr.rotation + 2 * PI, 1, 
											Tween.TRANS_CUBIC, Tween.EASE_OUT)
		pushAnimation.start()
		$Lena.controllable = false
		$Crush.play()
		yield(pushAnimation, "tween_all_completed")
		pushedBack = false
		$Lena.controllable = true

func startRiding():
	riding = true
	TimeHolder.resumeCounting()
	$CarSpawner.startSpawning()
	get_node("Lena/Helpers").show()
	$Lena.controllable = true

func finishRiding():
	for child in get_children():
		if child.get_script() == preload("res://RoadScene/Car.gd"):
			child.acceleration = child.acceleration + 200
	riding = false
	TimeHolder.pauseCounting()
	$CarSpawner.stopSpawning()
	$Lena.controllable = false
	endAnimation.interpolate_property(	$Avtovo, "position:x", $Avtovo.position.x, $Avtovo.position.x + 1400,
										5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	endAnimation.interpolate_property(	$Background, "position:x", $Background.position.x, $Background.position.x + 300,
										5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	endAnimation.interpolate_property(	$Lena, "position:x", $Lena.position.x, 1280 / 2, 2,
										Tween.TRANS_CUBIC, Tween.EASE_IN, 4)
	endAnimation.interpolate_property(	$Lena, "position:y", $Lena.position.y, 720 / 2 + 100, 2,
										Tween.TRANS_CUBIC, Tween.EASE_IN, 4)
	endAnimation.interpolate_property(	$Lena, "rotation", $Lena.rotation, $Lena.rotation + PI / 3, 2,
										Tween.TRANS_CUBIC, Tween.EASE_IN, 4)
	endAnimation.interpolate_property(	$Lena, "modulate:a", 1, 0, 0.5,
										Tween.TRANS_EXPO, Tween.EASE_IN, 5.5)
	endAnimation.interpolate_property(	get_node("Lena/Sprite"), "scale", get_node("Lena/Sprite").scale, 
										get_node("Lena/Sprite").scale / 2, 2, Tween.TRANS_CUBIC, Tween.EASE_IN, 4)
	endAnimation.interpolate_property(	$Ambient, "volume_db", $Ambient.volume_db, 
										$Ambient.volume_db - 80, 6, Tween.TRANS_CUBIC, Tween.EASE_IN)
	endAnimation.start()
	yield(get_tree().create_timer(4), "timeout")
	$EndRide.play()
	yield(get_tree().create_timer(2), "timeout")
	$Door.play()
	
func _process(delta):
	if riding and !pushedBack:
		progress += 0.018 * delta
	if progress >= 1 and riding:
		finishRiding()
