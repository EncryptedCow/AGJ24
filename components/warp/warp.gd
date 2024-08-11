class_name Warp
extends Sprite2D

@export var target: Node2D
@export var disable_on_ready: bool = true
@export var next_enemy_group: EnemyGroupWarp
@export var warp_pointer: Node2D

@export var is_last_warp: bool = false
@export var next_dialogue_seq: DialogueSequence

func _ready() -> void:
	if disable_on_ready:
		visible = false
		%Area2D.monitoring = false

func enable() -> void:
	visible = true
	%Area2D.monitoring = true

func _on_player_entered(area: Area2D) -> void:
	if is_last_warp:
		Global.dialogue_sequence = next_dialogue_seq
		get_tree().change_scene_to_packed.call_deferred(Global.arcade_scene)
	else:
		warp_pointer.visible = false
		area.owner.global_position = target.global_position

func _process(delta: float) -> void:
	rotation_degrees += 360 * delta
