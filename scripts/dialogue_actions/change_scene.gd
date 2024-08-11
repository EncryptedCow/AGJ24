class_name DChangeScene
extends DialogueAction

@export_file("*.tscn") var next_scene: String

func do_action(seq: DialogueSequencer) -> void:
	seq.get_tree().change_scene_to_file(next_scene)
