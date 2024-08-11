class_name DChangeScene
extends DialogueAction

@export var next_scene: PackedScene

func do_action(seq: DialogueSequencer) -> void:
	seq.get_tree().change_scene_to_packed(next_scene)
