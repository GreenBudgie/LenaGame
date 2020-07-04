extends Timer

const FLYING_PIGEON = preload("Pigeons/FlyingPigeon.tscn")
const JUMPING_PIGEON = preload("Pigeons/JumpingPigeon.tscn")
const START_SPAWN_RATE = 5.0
const MIN_SPAWN_RATE = 1.0

var currentSpawnRate = START_SPAWN_RATE

func startSpawning():
	connect("timeout", self, "spawnPigeon")
	start(START_SPAWN_RATE)

func stopSpawning():
	stop()
#	var pigeons = get_parent().get_children()
#	for pigeon in pigeons:
#		print(pigeon)
#		pass

func spawnPigeon():
	if randf() > 0.5:
		get_parent().add_child(FLYING_PIGEON.instance())
	else:
		get_parent().add_child(JUMPING_PIGEON.instance())
	currentSpawnRate = max(currentSpawnRate - 0.3, MIN_SPAWN_RATE)
	start(currentSpawnRate)
