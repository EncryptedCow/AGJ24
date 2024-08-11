extends Node

func _go_to_credits() -> void:
	get_tree().change_scene_to_file("res://scenes/end_game_credits.tscn")
