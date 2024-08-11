extends Node2D

func _ready() -> void:
	for child in get_children():
		child.tree_exited.connect(func():
			if get_child_count() == 0:
				Global.dialogue_sequence = load("res://dialogue_sequences/cabinet4_complete.tres")
				get_tree().change_scene_to_packed.call_deferred(Global.arcade_scene)
		)
