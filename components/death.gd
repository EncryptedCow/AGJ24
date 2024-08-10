class_name Death
extends Node

@export var stats: Stats

func _ready() -> void:
	stats.im_dead.connect(_entity_died)

func _entity_died() -> void:
	print("entity died")
