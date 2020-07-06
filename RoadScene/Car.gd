extends Area2D

const MIN_SPEED = 50

var availableColors = [	Color.chartreuse, Color.crimson, Color.white, 
						Color.gray, Color.aquamarine, Color.lawngreen, Color.salmon, Color.wheat]
var acceleration
var startSpeed
var speed

onready var lena = get_parent().get_node("Lena")

func _ready():
	randomize()
	#Picking random color for a car
	modulate = availableColors[randi() % availableColors.size()]
	
	acceleration = rand_range(-50, 200)
	startSpeed = rand_range(200, 500)
	if acceleration < 0: startSpeed += 100
	speed = startSpeed

func calculateCollisions():
	if lena != null:
		if overlaps_area(lena):
			pass #TODO
	for child in get_parent().get_children():
		if child is Area2D and overlaps_area(child):
			if child.get_script() == self.get_script():
				if child.position.x < self.position.x:
					setPushed(child)
				else:
					child.setPushed(self)
			if child.get_script() == preload("res://RoadScene/Sportcar.gd"):
				setPushed(child)

func setPushed(car):
	speed = car.speed * 1.5

func _process(delta):
	position.x += speed * delta
	speed = max(speed + acceleration * delta, MIN_SPEED)
	calculateCollisions()
	if position.x > Globals.SCREEN_WIDTH + 100:
		queue_free()
