extends Node

@export var arcade_scene: PackedScene
@export var bullet: PackedScene
@export var car: PackedScene

var bullet_container: BulletContainer
var player_character: CharacterBody2D # the main player to be referenced by enemies
var dialogue_sequence: DialogueSequence = preload("res://dialogue_sequences/new_game.tres")
var death_dialogue: DialogueSequence
var damage: int = 1
