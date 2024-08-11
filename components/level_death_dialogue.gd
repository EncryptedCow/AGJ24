class_name LevelDeathDialogue
extends Node

@export var death_sequence: DialogueSequence

func _ready() -> void:
	Global.death_dialogue = death_sequence
