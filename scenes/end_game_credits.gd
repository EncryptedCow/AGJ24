extends Control

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
