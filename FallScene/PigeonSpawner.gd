extends Timer

const FLYING_PIGEON = preload("Pigeons/FlyingPigeon.tscn")
const START_SPAWN_RATE = 5
const MIN_SPAWN_RATE = 1

var currentSpawnRate = START_SPAWN_RATE

func startSpawning():
	connect("timeout", self, "spawnPigeon")
	start(START_SPAWN_RATE)

func stopSpawning():
	stop()
	var pigeons = get_parent().get_children()
	for pigeon in pigeons:
		print(pigeon)
		pass

func spawnPigeon():
	get_parent().add_child(FLYING_PIGEON.instance())
	currentSpawnRate = max(currentSpawnRate - 0.1, MIN_SPAWN_RATE)
	start(currentSpawnRate)
