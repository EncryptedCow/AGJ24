class_name EnemyController

extends Node

enum MovementType {
	RANDOM, # the direction chosen is determined randomly
	DIRECTION, # moves the opposite direction of the wall it collided on
	PURSUE  # attempts to move towards the player
}

enum EnemyDirection {
	DIRECTION_UP,
	DIRECTION_DOWN,
	DIRECTION_LEFT,
	DIRECTION_RIGHT,
	DIRECTION_BOTTOMRIGHT,
	DIRECTION_BOTTOMLEFT,
	DIRECTION_TOPLEFT,
	DIRECTION_TOPRIGHT
	
}

@export var body: CharacterBody2D
@export var randomize_behaviour: bool = true
@export var move_timer: Timer
@export var move_speed: float = 75
@export var idle_time_range: Vector2 = Vector2(1.0, 2.5)
@export var move_time_range: Vector2 = Vector2(1.0, 2.5)
@export var move_type: MovementType = MovementType.DIRECTION 
@export var move_direction: EnemyDirection

var is_idle: bool = true
var move_dir: Vector2
var fire_dir: Vector2

# stores pre-defined directions to be used with MovementType.RANDOM
var movement_dir_list: Array[Vector2] = [
	Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT,
	Vector2(1, 1).normalized(), # Bottom right
	Vector2(-1, 1).normalized(), # Bottom left
	Vector2(-1, -1).normalized(), # Top left
	Vector2(1, -1).normalized() # Top right
]

func _get_enum_direction(EnumDirection) -> Vector2:
	return movement_dir_list[EnumDirection]
			
func _ready():
	# randomize enemy behaviour
	if randomize_behaviour == true:
		move_type = MovementType.values().pick_random()
		move_dir = movement_dir_list.pick_random()
		
	# movement type
	if(move_type == MovementType.RANDOM):
		move_dir = movement_dir_list.pick_random()
	elif(move_type == MovementType.PURSUE):
		_on_movement_timer_timeout()
	elif(move_type == MovementType.DIRECTION):
		move_dir = _get_enum_direction(move_direction)
		

# "bounce" off the wall using the wall's normal
func _on_wall_collision() -> void:	
	var wall_normal: Vector2 = body.get_wall_normal()
	print(wall_normal)
	if wall_normal != null:
		move_dir = move_dir.bounce(wall_normal)
	else:
		move_dir *= -1

# determine new random direction based on 4 cardinal directions
func _on_movement_timer_timeout() -> void:
	if(move_type == MovementType.RANDOM):
		var time_range: Vector2 = idle_time_range if is_idle else move_time_range
		is_idle = !is_idle
		move_dir = movement_dir_list.pick_random()
		move_timer.start(randf_range(time_range.x, time_range.y))
	elif(move_type == MovementType.PURSUE):
		if Global.player_character == null: # do not fire if the player doesn't exist
			return
		var enemy_pos: Vector2 = owner.global_position
		var player_pos: Vector2 = Global.player_character.global_position
		move_dir = enemy_pos.direction_to(player_pos)
		
func _physics_process(delta: float) -> void:
	
	match move_type:
		MovementType.RANDOM:	
			if !is_idle:
				body.velocity = move_dir * move_speed
				body.move_and_slide()
		_:
			body.velocity = move_dir * move_speed
			body.move_and_slide()
			
	if body.is_on_wall(): #|| body.is_on_ceiling() || body.is_on_floor():
		#print("Wall Collided")
		_on_wall_collision()


