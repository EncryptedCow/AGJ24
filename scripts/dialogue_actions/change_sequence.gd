class_name DChangeSequence
extends DialogueAction

@export var next_sequence: DialogueSequence

func do_action(seq: DialogueSequencer) -> void:
	seq.curr_seq = next_sequence.action_list.duplicate()
	seq.do_actions()
