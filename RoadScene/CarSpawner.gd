extends Timer

const START_SPAWN_RATE = 1.0
const MAX_SPAWN_RATE = 1.8
const MIN_SPAWN_RATE = 0.35
const positions = [120, 360, 600]

var CAR = preload("res://RoadScene/Car.tscn")
var SPORTCAR = preload("res://RoadScene/Sportcar.tscn")

func startSpawning():
	randomize()
	connect("timeout", self, "spawnCar")
	start(START_SPAWN_RATE)
	
func getRandomPos():
	return positions[randi() % positions.size()]

func spawnCar():
	var spawnRate = MIN_SPAWN_RATE + (MAX_SPAWN_RATE - MIN_SPAWN_RATE) * (1 - get_parent().progress)
	var car
	if randf() > 0.3 or get_parent().progress < 0.4:
		car = CAR.instance()
	else:
		car = SPORTCAR.instance()
	car.position.x = -100
	car.position.y = getRandomPos()
	get_parent().add_child(car)
	start(spawnRate)

func stopSpawning():
	stop()
