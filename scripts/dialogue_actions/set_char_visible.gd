class_name DSetCharVisible
extends DialogueAction

enum Character {
	Mike, Fred
}

@export var character: Character = Character.Fred
@export var visible: bool = true

func do_action(seq: DialogueSequencer) -> void:
	var sprite: Sprite2D = seq.mike if character == Character.Mike else seq.fred
	sprite.visible = visible
