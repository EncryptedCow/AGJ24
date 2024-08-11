class_name LevelSettings
extends RefCounted

var max_rooms: int
var dead_end_start: int
var room_generator: RoomGenerator

func _init(max_rooms: int, dead_end_start: int, room_gen: RoomGenerator) -> void:
	self.max_rooms = max_rooms
	self.dead_end_start = dead_end_start
	self.room_generator = room_gen
