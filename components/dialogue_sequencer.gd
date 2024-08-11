class_name DialogueSequencer
extends Node

@export var dialogue: RichTextLabel
@export var action: Label
@export var cabinet_location: Control

var curr_seq: Array[DialogueAction]
var await_input: bool = false

func _ready() -> void:
	curr_seq = Global.dialogue_sequence.action_list.duplicate()
	do_actions()

func do_actions() -> void:
	while !await_input and curr_seq.size() > 0:
		var next_action: DialogueAction = curr_seq.pop_front()
		next_action.do_action(self)


func _on_action_gui_input(event: InputEvent) -> void:
	if await_input and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			await_input = false
			do_actions()
