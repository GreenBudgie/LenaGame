extends "res://SubwayScene/Collidable.gd"

var tween = Tween.new()

func _ready():
	add_child(tween)
	randomize()
	var sprites = $Sprites
	var sprite = sprites.get_children()[randi() % sprites.get_child_count()]
	for child in sprites.get_children():
		if sprite != child: child.visible = false

func onCollide():
	var yShift = 120
	match status:
		CollideStatus.CRUSH:
			tween.interpolate_property(self, "rotation", rotation, rotation - PI * 4.5, 2, Tween.TRANS_CUBIC, Tween.EASE_OUT)
			tween.interpolate_property(self, "position:y", position.y, position.y + yShift, 2, Tween.TRANS_BACK, Tween.EASE_OUT)
		CollideStatus.JUMP:
			tween.interpolate_property(self, "rotation", rotation, rotation + PI / 2, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
			tween.interpolate_property(self, "position:y", position.y, position.y + yShift, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		CollideStatus.PUSH:
			tween.interpolate_property(self, "rotation", rotation, rotation + PI / 2, 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
			tween.interpolate_property(self, "position:x", position.x, position.x + 400, 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
			tween.interpolate_property(self, "position:y", position.y, position.y + yShift, 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()

func _process(delta):
	checkCollisions()
	var speed = get_parent().SPEED
	position.x += speed * delta
	if position.x > Globals.SCREEN_WIDTH + 200:
		queue_free()
