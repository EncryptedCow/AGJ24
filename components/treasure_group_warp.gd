class_name TreasureGroupWarp
extends Node

# @export var enable_warp: Warp # The warp to activate upon group completion (unused)

# set signal for each child to call _check_children when it is destroyed
func _ready() -> void:
	for child in get_children():
		child.tree_exited.connect(_check_children)

func _check_children() -> void:
	if get_child_count() == 0: # all treasure has been collected
		print("YOU WIN!!")
		Global.dialogue_sequence = load("res://dialogue_sequences/cabinet3_complete.tres")
		get_tree().change_scene_to_packed.call_deferred(Global.arcade_scene)
		#enable_warp.enable() # activate warp
