extends Node

@export var start_button: Button
@export var start_level: PackedScene
@export var start_animation: AnimationPlayer
@export var quit_button: Button
@export var credits_button: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#start_button.text = " > BEGIN <"
	start_button.pressed.connect(self._start_button_pressed)
	credits_button.pressed.connect(self._credits_button_pressed)
	
	quit_button.pressed.connect(self._quit_button_pressed)

func _start_button_pressed() -> void:
	start_button.visible = false
	quit_button.visible = false
	start_animation.play("fade_out")

func _quit_button_pressed() -> void:
	get_tree().quit()

func _credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/end_game_credits.tscn")

func _start_game() -> void:
	print("Game will begin.")
	get_tree().change_scene_to_packed(start_level)

