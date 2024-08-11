class_name Hurtbox
extends Area2D

func _on_area_entered(area: Area2D) -> void:
	_test_hit(area)

func _on_body_entered(body: Node2D) -> void:
	_test_hit(body)

func _test_hit(hit_node: Node) -> void:
	if is_instance_of(hit_node, Hitbox):
		if hit_node.owner == owner.origin_entity:
			return
		
		var hitbox: Hitbox = hit_node
		hitbox.hit(self)
		owner.queue_free()
		#print("YEOWCH")
	else:
		owner.queue_free()
