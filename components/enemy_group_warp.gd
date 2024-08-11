class_name EnemyGroupWarp
extends Node

@export var enable_warp: Warp

func _ready() -> void:
	for child in get_children():
		child.tree_exited.connect(_check_children)

func _check_children() -> void:
	if get_child_count() == 0:
		enable_warp.enable()
