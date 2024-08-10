class_name Hurtbox
extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if is_instance_of(area, Hitbox):
		if area.owner == owner.origin_entity:
			return
		
		var hitbox: Hitbox = area
		print("bullet hit damageable entity")
		hitbox.hit(self)
	else:
		print("bullet hit terrain")
