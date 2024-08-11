class_name TreasurePickup
extends Node2D

# for use with player only
# when it collides with the player, it will be destroyed
func _test_touch_hit(area: Area2D) -> void:
	if get_parent().get_child_count() == 1:
		Global.dialogue_sequence = load("res://dialogue_sequences/cabinet3_complete.tres")
		get_tree().change_scene_to_packed.call_deferred(Global.arcade_scene)
	print("Treasure collided")
	self.queue_free()
