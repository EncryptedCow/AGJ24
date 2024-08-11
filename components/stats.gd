class_name Stats
extends Node

@export var hitbox: Hitbox

@export var health: float = 10.0

func _ready() -> void:
	hitbox.was_hit.connect(_take_damage)

func _take_damage(damage: float) -> void:
	health -= minf(damage, health)
	if health <= 0:
		print("im ded")
		owner.queue_free()
