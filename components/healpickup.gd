class_name HealPickup
extends Node2D

# for use with player only
func _test_touch_hit(area: Area2D) -> void:
	#print("Health collided")
	var hitbox: Hitbox = area
	hitbox.heal(self)
