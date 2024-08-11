class_name DSetCabinet
extends DialogueAction

@export var cabinet_scene: PackedScene

func do_action(seq: DialogueSequencer) -> void:
	for child in seq.cabinet_location.get_children():
		child.queue_free()
	seq.cabinet_location.add_child(cabinet_scene.instantiate())
