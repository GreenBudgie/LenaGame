extends Area2D

const MIN_SPEED = 50
const LENA_THRESHOLD = 20

var availableColors = [	Color.crimson, Color.white, 
						Color.gray, Color.aquamarine, Color.lawngreen, Color.salmon, Color.wheat]
var acceleration
var startSpeed
var speed
var collided = false
var pushed = false
var vSpeed = 0

onready var lena = get_parent().get_node("Lena")

func _ready():
	randomize()
	#Picking random color for a car
	modulate = availableColors[randi() % availableColors.size()]
	
	acceleration = rand_range(-50, 200)
	startSpeed = rand_range(250, 500)
	if acceleration < 0: startSpeed += 100
	speed = startSpeed
	$Sound.play()

func collideWithLena():
	if !collided:
		get_parent().pushBack()
		collided = true

func calculateCollisions():
	if vSpeed == 0 and lena != null and overlaps_area(lena):
		if lena.position.x - LENA_THRESHOLD < position.x:
			if vSpeed == 0: $Push.play()
			if lena.position.y > position.y:
				vSpeed = -800
			else:
				vSpeed = 800
		else:
			collideWithLena()
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
	if !pushed:
		pushed = true
		$Crash.play()
		speed = car.speed * 1.5

func _process(delta):
	position.x += speed * delta
	speed = max(speed + acceleration * delta, MIN_SPEED)
	calculateCollisions()
	if vSpeed != 0 and !collided:
		position.y += vSpeed * delta
	if collided:
		rotation += 6 * delta
	if position.x > Globals.SCREEN_WIDTH + 100 and !$Sound.playing:
		queue_free()
