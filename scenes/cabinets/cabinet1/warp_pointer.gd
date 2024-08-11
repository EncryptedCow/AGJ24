extends Node2D

@export var next_warp: Node2D

func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	look_at(next_warp.global_position)
