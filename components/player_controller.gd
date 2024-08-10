class_name PlayerController
extends Node

@export var body: CharacterBody2D
@export var camera: Camera2D

@export var move_speed: float = 100

var aim_pos: Vector2
var gamepad_aiming: bool = false

func _ready() -> void:
	Global.player_character = owner

func _process(delta: float) -> void:
	if gamepad_aiming:
		pass
	else:
		aim_pos = camera.get_global_mouse_position()

func _physics_process(delta: float) -> void:
	var input_v2: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var movement: Vector2 = input_v2 * move_speed
	
	body.velocity = movement
	body.move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		var new_bullet: Bullet = Global.bullet.instantiate()
		
		# set up bullet ownership
		new_bullet.origin_entity = owner
		new_bullet._setup_player_masks()
		
		new_bullet.direction = (aim_pos - owner.global_position).normalized()
		
		Global.bullet_container.add_child(new_bullet)
		new_bullet.global_position = owner.global_position
	
	## TODO: Toggle between gamepad aiming and mouse aiming if right thumbstick or mouse move respecitvely
