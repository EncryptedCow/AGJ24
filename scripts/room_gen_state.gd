class_name RoomGenState
extends RefCounted

var origin_link: RoomLink
var room_count: int
var level_settings: LevelSettings

var room_pool: Array[PackedScene] = []

var found_room: Node
var child_rooms: Array[RoomGenState] = []

func _init(origin_link: RoomLink, room_count: int, level_settings: LevelSettings) -> void:
	self.origin_link = origin_link
	self.room_count = room_count
	self.level_settings = level_settings
	
	_select_room_pool()
	#found_room = _find_valid_room()

func _select_room_pool() -> void:
	if room_count < level_settings.dead_end_start:
		room_pool = RoomList.through_rooms.duplicate()
	elif room_count < level_settings.max_rooms:
		room_pool = RoomList.through_rooms.duplicate()
		room_pool.append_array(RoomList.dead_end_rooms)
	else:
		room_pool = RoomList.dead_end_rooms
	
	randomize()
	room_pool.shuffle()

func _get_next_room() -> Node:
	if room_pool.size() == 0:
		return null
	
	return room_pool.pop_back().instantiate()

#func _find_valid_room()

func gen_room() -> void:
	var new_room: Node = _get_next_room()
	var origin_attached_link: RoomLink
	
	while room_pool.size() > 0:
		var room_loc: Vector2 = Vector2.ZERO
		if origin_link.link_direction != RoomLink.LinkDirection.Origin:
			var matching_link: RoomLink = _get_room_matching_link(new_room)
			if matching_link == null:
				new_room = _get_next_room()
				continue
			origin_attached_link = matching_link
			room_loc = origin_link.global_position + matching_link.position * -1
		
		new_room.position = room_loc
		level_settings.room_generator.add_child(new_room)
		
		if _does_room_overlap(new_room):
			print("room overlaps")
			new_room.queue_free()
			new_room = _get_next_room()
			continue
		
		for link in _get_room_links(new_room):
			if link == origin_attached_link:
				continue
			var gen_state := RoomGenState.new(link, room_count + 1, level_settings)
			gen_state.gen_room()
		
		break

func _find_valid_room_fucked() -> Node:
	var room_to_validate: Node = _get_next_room()
	var room_is_valid: bool = false
	
	while !room_is_valid and room_pool.size() > 0:
		var link_offset: Vector2 = Vector2.ZERO
		var matching_link: RoomLink
		# check that the new room has a matching room link
		if origin_link.link_direction != RoomLink.LinkDirection.Origin:
			matching_link = _get_room_matching_link(room_to_validate)
			if matching_link == null:
				#print("room has no valid link")
				room_to_validate = _get_next_room()
				continue
			else:
				link_offset = matching_link.position * -1
				room_to_validate.position = origin_link.global_position + link_offset
		else:
			print("origin link")
		# add room to scene and ensure no overlapping with other rooms
		level_settings.room_generator.add_child(room_to_validate)
		if _does_room_overlap(room_to_validate):
			level_settings.room_generator.remove_child(room_to_validate)
			room_to_validate.queue_free()
			room_to_validate = _get_next_room()
			continue
		
		var links: Array[RoomLink] = _get_room_links(room_to_validate)
		var found_invalid_link: bool = false
		for link in links:
			if link == matching_link:
				continue
			var gen_state := RoomGenState.new(link, room_count + 1, level_settings)
			#print(gen_state.found_room)
			if gen_state.found_room != null:
				child_rooms.push_back(gen_state)
				print("good link")
			else:
				found_invalid_link = true
				break
		if found_invalid_link:
			level_settings.room_generator.remove_child(room_to_validate)
			room_to_validate.queue_free()
			room_to_validate = _get_next_room()
			continue
		else:
			room_is_valid = true
			return room_to_validate
		## room should be valid????
	#print("room is not valid")
	return null

func _get_room_matching_link(room: Node) -> RoomLink:
	for child in room.get_children():
		if !is_instance_of(child, RoomLink):
			continue
		if origin_link.does_link_match_dir(child):
			return child
	return null

func _does_room_overlap(room: Node) -> bool:
	var room_area: Area2D = room.get_node("RoomBB")
	return room_area.has_overlapping_areas()

func _get_room_links(room: Node) -> Array[RoomLink]:
	var room_links: Array[RoomLink] = []
	for child in room.get_children():
		if is_instance_of(child, RoomLink):
			room_links.push_back(child)
	return room_links
