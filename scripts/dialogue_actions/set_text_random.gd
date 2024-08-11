class_name DSetTextRandom
extends DialogueAction

@export var line_list: Array[String]

func do_action(seq: DialogueSequencer) -> void:
	seq.dialogue.text = line_list.pick_random()
