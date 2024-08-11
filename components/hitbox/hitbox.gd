class_name Hitbox
extends Area2D

signal was_hit(damage: float)
signal heal_picked_up(heal: float)

func hit(hurtbox: Hurtbox) -> void:
	was_hit.emit(1)
	
func heal(pickup: Node) -> void:
	heal_picked_up.emit(pickup) # send a signal to heal for 1 damage
