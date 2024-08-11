extends CharacterBody2D

@export var sprite: Sprite2D
@export var move_timer: Timer
@export var range_attack_timer: Timer
@export var dash_attack_timer: Timer

const BASE_SPEED: float = 50.0
var current_speed: float = BASE_SPEED
var alerted: bool = false
var is_dashing: bool = false
var move_dir: Vector2 = Vector2.ZERO

# determine new direction based on position of player and clamped to 4 cardinal directions
func _on_movement_timer_timeout() -> void:
	if alerted == false:
		return
	if Global.player_character == null: # do NOT check if the player doesn't exist
		return 
	
	print("Tank Boss: SCANNING FOR TARGET")
	# calculate new movement direction
	var enemy_pos: Vector2 = global_position
	var player_pos: Vector2 = Global.player_character.global_position
	var rounded_pos: Vector2 = enemy_pos.direction_to(player_pos).round()
	
	if rounded_pos.x != 0:
		move_dir = Vector2(rounded_pos.x, 0)
	else:
		move_dir = Vector2(0, rounded_pos.y)
	print(move_dir)
	
	sprite.rotation = move_dir.angle()
	
	# restart timer
	move_timer.start(randf_range(1.0, 3.0))

func _on_range_attack_timer_timeout():
	if alerted == false:
		return
	if Global.player_character == null: # do NOT check if the player doesn't exist
		return 
	
	print("Tank Boss: I'VE GOT YOU IN MY SIGHTS")
	var new_bullet: Bullet = Global.bullet.instantiate()
	new_bullet.origin_entity = owner
	new_bullet._setup_enemy_tank()
	
	var enemy_pos: Vector2 = global_position
	var player_pos: Vector2 = Global.player_character.global_position
	new_bullet.direction = enemy_pos.direction_to(player_pos)
	print(global_position)
	
	# add bullet to global container and set position to enemy's position
	Global.bullet_container.add_child(new_bullet)
	new_bullet.global_position = global_position
	
# "bounce" off the wall using the wall's normal
func _on_wall_collision() -> void:	
	var wall_normal: Vector2 = get_wall_normal()
	#print(wall_normal)
	move_dir *= -1
	sprite.rotation = move_dir.angle()
	
	
func _physics_process(delta: float) -> void:
	if alerted == true:
		velocity = move_dir * current_speed
		move_and_slide()
	
		if is_on_wall(): #|| body.is_on_ceiling() || body.is_on_floor():
			_on_wall_collision()

func _on_area_vision_circle_entered(area: Area2D) -> void:
	if alerted == false:
		print("Tank Boss: I HAVE FOUND YOU, PREPARE TO DIE")
		dash_attack_timer.start()
		alerted = true

func _on_dash_timer_timeout():
	is_dashing = !is_dashing
	
	if is_dashing:
		print("Tank Boss: I'M GONNA FLATTEN YOU")
		
		current_speed = BASE_SPEED * 5
		dash_attack_timer.wait_time = 3
	else:
		print("Tank Boss: COOLING DOWN...")
		current_speed = BASE_SPEED
		dash_attack_timer.wait_time = 1
