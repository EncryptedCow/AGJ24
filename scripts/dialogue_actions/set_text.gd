class_name DSetText
extends DialogueAction

@export_multiline var text: String

func do_action(seq: DialogueSequencer) -> void:
	seq.dialogue.text = text
