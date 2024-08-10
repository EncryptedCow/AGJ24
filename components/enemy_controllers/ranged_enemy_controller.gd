class_name RangedEnemyController

extends Node

@export var body: CharacterBody2D
@export var move_timer: Timer
@export var move_speed: float = 75
@export var idle_time_range: Vector2 = Vector2(1.0, 2.5)
@export var move_time_range: Vector2 = Vector2(1.0, 2.5)

var is_idle: bool = true
var move_dir: Vector2

var movement_dir_list: Array[Vector2] = [
	Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT,
	Vector2(1, 1).normalized(), # Bottom right
	Vector2(-1, 1).normalized(), # Bottom left
	Vector2(-1, -1).normalized(), # Top left
	Vector2(1, -1).normalized() # Top right
]

func _on_movement_timer_timeout() -> void:
	var time_range: Vector2 = idle_time_range if is_idle else move_time_range
	is_idle = !is_idle
	move_dir = movement_dir_list.pick_random()
	move_timer.start(randf_range(time_range.x, time_range.y))

func _physics_process(delta: float) -> void:
	if !is_idle:
		body.velocity = move_dir * move_speed
		body.move_and_slide()
