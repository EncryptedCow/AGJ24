extends Control

@export var stats: Stats

func _ready() -> void:
	stats.health_changed.connect(_player_health_changed)

func _player_health_changed() -> void:
	%HealthBar.value = (stats.health / stats.max_health) * 100
