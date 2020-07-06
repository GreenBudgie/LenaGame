extends Area2D


var availableColors = [	Color.chartreuse, Color.crimson, Color.white, 
						Color.gray, Color.aquamarine, Color.lawngreen, Color.salmon, Color.wheat]
var acceleration
var startSpeed
var speed

func _ready():
	randomize()
	#Picking random color for a car
	modulate = availableColors[randi() % availableColors.size()]
	
	acceleration = rand_range(-50, 200)
	startSpeed = rand_range(200, 500)
	if acceleration < 0: startSpeed += 100
	speed = startSpeed

func _process(delta):
	position.x += speed * delta
	speed += acceleration * delta
	if position.x > Globals.SCREEN_WIDTH + 100:
		queue_free()
