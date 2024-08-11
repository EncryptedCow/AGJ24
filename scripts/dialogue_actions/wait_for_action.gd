class_name DWaitForAction
extends DialogueAction

@export var action_text: String

func do_action(seq: DialogueSequencer) -> void:
	seq.await_input = true
	seq.action.text = action_text
