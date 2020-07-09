extends Area2D

const Y_THRESHOLD = 150

enum CollideStatus {UNKNOWN, CRUSH, JUMP, PUSH}

var status = CollideStatus.UNKNOWN

func checkCollisions():
	var lenaArea: Area2D = get_node("../Lena/Area2D")
	if lenaArea != null and status == CollideStatus.UNKNOWN and lenaArea.overlaps_area(self):
		var lenaX = get_node("../Lena").position.x
		var lenaY = get_node("../Lena").position.y
		status = CollideStatus.CRUSH
		if position.y - lenaY > Y_THRESHOLD:
			status = CollideStatus.JUMP
		elif lenaX < position.x:
			status = CollideStatus.PUSH
		onCollide()
		get_node("../Lena").onCollide(self)
		if status == CollideStatus.CRUSH:
			get_parent().collide()

func onCollide():
	pass
