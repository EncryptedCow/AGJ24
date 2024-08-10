extends Node2D

func _ready() -> void:
	var start_room_list: Array[PackedScene] = RoomList.dead_end_rooms if randf() <= 0.5 else RoomList.through_rooms
	var first_room: Node = start_room_list.pick_random().instantiate()
	add_child(first_room)

func _gen_next_rooms(room: Node) -> void:
	pass
