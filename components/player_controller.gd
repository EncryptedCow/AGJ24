class_name PlayerController
extends Node

@export var body: CharacterBody2D

@export var move_speed: float = 100

func _physics_process(delta: float) -> void:
	var input_v2: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var movement: Vector2 = input_v2 * move_speed
	
	body.velocity = movement
	body.move_and_slide()
