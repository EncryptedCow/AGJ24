class_name Warp
extends Sprite2D

@export var target: Node2D
@export var disable_on_ready: bool = true

func _ready() -> void:
	if disable_on_ready:
		visible = false
		%Area2D.monitoring = false

func enable() -> void:
	visible = true
	%Area2D.monitoring = true

func _on_player_entered(area: Area2D) -> void:
	
	area.owner.global_position = target.global_position

func _process(delta: float) -> void:
	rotation_degrees += 360 * delta
