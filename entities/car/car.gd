
extends Area2D

enum Direction { Left, Right }

var speed: float = 750

var direction: Direction = Direction.Right:
	set(v):
		direction = v
		if v == Direction.Left:
			%Sprite2D.rotation_degrees = 270
		elif v == Direction.Right:
			%Sprite2D.rotation_degrees = 90

func _process(delta: float) -> void:
	var dir_vec: Vector2 = Vector2.RIGHT if direction == Direction.Right else Vector2.LEFT
	position += dir_vec * speed * delta
