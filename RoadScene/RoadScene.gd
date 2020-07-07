extends Node2D

var riding = false
var pushedBack = false
var progress = 0

onready var pushAnimation = Tween.new()

func _ready():
	add_child(pushAnimation)
	startRiding() #TODO

func pushBack():
	if !pushedBack:
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
	$CarSpawner.startSpawning()
	$Lena.controllable = true

func finishRiding():
	riding = false
	$CarSpawner.stopSpawning()
	$Lena.controllable = false
	
func _process(delta):
	if riding and !pushedBack:
		progress += 0.018 * delta
	if progress >= 1:
		finishRiding()
