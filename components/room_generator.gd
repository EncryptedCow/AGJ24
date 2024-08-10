class_name RoomGenerator
extends Node2D

var valid_room_count: int = 0
@export var max_rooms: int = 10
@export var dead_end_start: int = 7

func _ready() -> void:
	var first_room: Node = select_random_room().instantiate()
	var links: Array[RoomLink] = get_links_in_room(first_room)
	print(links)
	add_child(first_room)

func select_random_room() -> PackedScene:
	var room_pool: Array[PackedScene]
	
	# between 0 (inclusive) and dead_end_start (exclusive) -> through room
	# between dead_end_start (inclusive) and max_rooms (exclusive) -> 50/50 through room or dead end
	# >= max_rooms -> dead end
	if valid_room_count < dead_end_start:
		room_pool = RoomList.through_rooms
	elif valid_room_count >= dead_end_start and valid_room_count < max_rooms:
		room_pool = RoomList.through_rooms if randf() <= 0.5 else RoomList.dead_end_rooms
	else:
		room_pool = RoomList.dead_end_rooms
	
	return room_pool.pick_random()

func get_links_in_room(room: Node) -> Array[RoomLink]:
	var links: Array[RoomLink] = []
	
	for child in room.get_children():
		if is_instance_of(child, RoomLink):
			links.push_back(child)
	
	return links
