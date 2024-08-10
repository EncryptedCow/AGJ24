class_name Hitbox
extends Area2D

signal was_hit(damage: float)

func hit(hurtbox: Hurtbox) -> void:
	print("hit by hurtbox")
	was_hit.emit(1)
