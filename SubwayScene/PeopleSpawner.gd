extends Timer

const THRESHOLD = 0.4
const START_SPAWN_RATE = 1.0
const MAX_SPAWN_RATE = 3.25
const MIN_SPAWN_RATE = 0.8

var GRANNY = preload("res://SubwayScene/Granny.tscn")
var CHILD = preload("res://SubwayScene/Children.tscn")

func startSpawning():
	randomize()
	connect("timeout", self, "spawn")
	start(START_SPAWN_RATE)

func spawn():
	var spawnRate = MIN_SPAWN_RATE + (MAX_SPAWN_RATE - MIN_SPAWN_RATE) * (1 - get_parent().progress)
	var pos = Vector2(-100, 500)
	var human
	if randf() > get_parent().progress / 1.5 or get_parent().progress < 0.25:
		human = GRANNY.instance()
	else:
		pos.y += 50
		human = CHILD.instance()
	human.position = pos
	get_parent().add_child(human)
	start(spawnRate + rand_range(-THRESHOLD, THRESHOLD))

func stopSpawning():
	stop()
