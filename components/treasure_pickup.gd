class_name TreasurePickup
extends Node2D

# for use with player only
# when it collides with the player, it will be destroyed
func _test_touch_hit(area: Area2D) -> void:
	print("Treasure collided")
	self.queue_free()
