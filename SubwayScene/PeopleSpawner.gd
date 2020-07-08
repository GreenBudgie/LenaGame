extends Timer

const START_SPAWN_RATE = 1.0
const MAX_SPAWN_RATE = 1.8
const MIN_SPAWN_RATE = 0.4
const POS = Vector2(-100, 500)

var GRANNY = preload("res://SubwayScene/Granny.tscn")

func startSpawning():
	randomize()
	connect("timeout", self, "spawn")
	start(START_SPAWN_RATE)

func spawn():
	var spawnRate = MIN_SPAWN_RATE + (MAX_SPAWN_RATE - MIN_SPAWN_RATE) * (1 - get_parent().progress)
	var human
	human = GRANNY.instance()
	human.position = POS
	get_parent().add_child(human)
	start(spawnRate)

func stopSpawning():
	stop()
