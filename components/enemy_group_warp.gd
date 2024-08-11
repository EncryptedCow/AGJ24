class_name EnemyGroupWarp
extends Node

@export var enable_warp: Warp
@export var disable_enemies: bool = true
@export var warp_pointer: Node2D

func _ready() -> void:
	for child in get_children():
		if disable_enemies:
			pass
			# disable enemy controller
		child.tree_exited.connect(_check_children)

func _check_children() -> void:
	if get_child_count() == 0 and enable_warp != null:
		enable_warp.enable()
		warp_pointer.next_warp = enable_warp
		warp_pointer.visible = true
