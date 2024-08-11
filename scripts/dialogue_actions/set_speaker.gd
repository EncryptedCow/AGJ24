class_name DSetSpeaker
extends DialogueAction

@export var speaker_name: String

func do_action(seq: DialogueSequencer) -> void:
	if speaker_name == "":
		seq.speaker_name.visible = false
	else:
		seq.speaker_name.text = speaker_name
		seq.speaker_name.visible = true

