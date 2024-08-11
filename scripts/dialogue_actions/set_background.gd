class_name DSetBackground
extends DialogueAction

@export var background: Texture2D

func do_action(seq: DialogueSequencer) -> void:
	seq.background.texture = background
