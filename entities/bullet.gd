class_name Bullet
extends Node2D

@export var hurtbox: CollisionObject2D
@export var sprite: AnimatedSprite2D
var origin_entity: Node
var direction: Vector2

# set up the masks as if the player owns this bullet
func _setup_player_masks() -> void:
	hurtbox.set_collision_mask_value(4, true)
	sprite.play(&"wrench")

# set pu the masks as if the enemy owns this bullet
func _setup_enemy_masks() -> void:
	hurtbox.set_collision_mask_value(3, true)
	#var tex = load("res://textures/enemies/EnemyAttack.png")
	sprite.play(&"enemy_bullet")
