class_name BulletController
extends Node

@export var bullet_root: Node2D
@export var speed: float = 250

func _process(delta: float) -> void:
	bullet_root.position += owner.direction * speed * delta
