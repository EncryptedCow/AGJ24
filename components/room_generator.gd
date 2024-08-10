class_name RoomGenerator
extends Node2D

var valid_room_count: int = 0
@export var max_rooms: int = 4
@export var dead_end_start: int = 2
@export var origin_room_link: RoomLink

func _ready() -> void:
	var level_settings: LevelSettings = LevelSettings.new(max_rooms, dead_end_start, self)
	var first_gen_state: RoomGenState = RoomGenState.new(origin_room_link, valid_room_count, level_settings)
	first_gen_state.gen_room()
