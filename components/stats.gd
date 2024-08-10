class_name Stats
extends Node

@export var hitbox: Hitbox

var health: float = 100.0

func _ready() -> void:
	hitbox.was_hit.connect(_take_damage)

func _take_damage(damage: float) -> void:
	print("entity takes %s damage" % damage)
	health -= minf(damage, health)
	if health <= 0:
		print("im ded")
