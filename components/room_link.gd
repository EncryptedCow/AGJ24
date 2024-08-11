class_name RoomLink
extends Marker2D

enum LinkDirection {
	Up, Down, Left, Right, Origin
}

const link_matches: Dictionary = {
	LinkDirection.Up: LinkDirection.Down,
	LinkDirection.Down: LinkDirection.Up,
	LinkDirection.Left: LinkDirection.Right,
	LinkDirection.Right: LinkDirection.Left
}

@export var link_direction: LinkDirection = LinkDirection.Up

func does_link_match_dir(other_link: RoomLink) -> bool:
	#print("this link dir: %s other link dir: %s expected: %s" % [ link_direction, other_link.link_direction, link_matches[link_direction] ])
	return link_matches[link_direction] == other_link.link_direction
