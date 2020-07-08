extends Node2D

const SPEED = 200

var progress = 0.0

func _ready():
	$PeopleSpawner.startSpawning()

func collide(obj):
	print("COLLIDE")
