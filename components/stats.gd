class_name Stats
extends Node

signal im_dead

var health: float = 100.0

func take_damage(damage: float) -> void:
	health -= minf(damage, health)
	if health <= 0:
		im_dead.emit()
