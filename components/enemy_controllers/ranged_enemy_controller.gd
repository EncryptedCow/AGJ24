class_name RangedEnemyController

extends EnemyController

enum FiringType {
	SHOOT_FORWARD, 			# enemy fires in front of them
	SHOOT_DIRECTION,	    # enemy always fires in specified direction
	SHOOT_TOWARD_ANGLE, 	# always fires towards the player
	SHOOT_TOWARD_CARDINAL	# fires in 8 directions towards the player
}

@export var fire_type: FiringType = FiringType.SHOOT_FORWARD
@export var firing_direction: EnemyDirection

func _get_enum_direction(EnumDirection) -> Vector2:
	return movement_dir_list[EnumDirection]

func _ready():
	super()
	
	# randomize enemy behaviour
	if randomize_behaviour == true:
		fire_type = FiringType.values().pick_random()
		firing_direction = EnemyDirection.values().pick_random()
		
	# return vector2 for a firing direction
	if(fire_type == FiringType.SHOOT_DIRECTION):
		fire_dir = _get_enum_direction(fire_type)

# fire a projectile
func _on_range_attack_timer_timeout():
	if Global.player_character == null: # do not fire if the player doesn't exist
		return
	
	var new_bullet: Bullet = Global.bullet.instantiate()
	new_bullet.origin_entity = owner
	new_bullet._setup_enemy_masks()
	
	# determine bullet's position based on firing type
	if(fire_type == FiringType.SHOOT_FORWARD): # fire where they're moving
		new_bullet.direction = move_dir 
	elif(fire_type == FiringType.SHOOT_DIRECTION): # fire at specified direction
		new_bullet.direction = fire_dir
	elif(fire_type == FiringType.SHOOT_TOWARD_ANGLE): # fire towards player	
		var enemy_pos: Vector2 = owner.global_position
		var player_pos: Vector2 = Global.player_character.global_position
		new_bullet.direction = enemy_pos.direction_to(player_pos)
	elif(fire_type == FiringType.SHOOT_TOWARD_CARDINAL): # fire towards player, to the nearest 8 directions 
		var enemy_pos: Vector2 = owner.global_position
		var player_pos: Vector2 = Global.player_character.global_position
		new_bullet.direction = enemy_pos.direction_to(player_pos).round()
	
	#print(Global.player_character.global_position)
	
	# add bullet to global container and set position to enemy's position
	Global.bullet_container.add_child(new_bullet)
	new_bullet.global_position = owner.global_position
	
	print()
