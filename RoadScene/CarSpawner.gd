extends Timer

const START_SPAWN_RATE = 1.0
const MAX_SPAWN_RATE = 1.0
const MIN_SPAWN_RATE = 0.4
const RATE_DECREMENT = 0.1
const positions = [120, 360, 600]

var CAR = preload("res://RoadScene/Car.tscn")
var SPORTCAR = preload("res://RoadScene/Sportcar.tscn")

var spawnRate = MAX_SPAWN_RATE

func startSpawning():
	connect("timeout", self, "spawnCar")
	start(START_SPAWN_RATE)
	
func getRandomPos():
	return positions[randi() % positions.size()]

func spawnCar():
	var car
	if randf() > 0.25:
		car = CAR.instance()
	else:
		car = SPORTCAR.instance()
	car.position.x = -100
	car.position.y = getRandomPos()
	get_parent().add_child(car)
	start(clamp(spawnRate - RATE_DECREMENT, MAX_SPAWN_RATE, MIN_SPAWN_RATE))

func stopSpawning():
	stop()
