class_name DPlayAnimation
extends DialogueAction

@export var anim_name: String

func do_action(seq: DialogueSequencer) -> void:
	seq.animator.play(anim_name)
