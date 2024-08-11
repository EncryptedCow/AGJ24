class_name Stats
extends Node

signal health_changed

@export var hitbox: Hitbox

@export var max_health: float = 10.0
@export var health: float = 10.0

func _ready() -> void:
	hitbox.was_hit.connect(_take_damage)
	hitbox.heal_picked_up.connect(_check_successful_pickup)

func _check_successful_pickup(pickup: Node) -> void:
	#print("Checking successful pickup...")
	if _heal_damage(2) == true:
		pickup.queue_free()
		#print("Success")
	else:
		print("Fail")

func _take_damage(damage: float) -> void:
	var damage_taken: float = minf(damage, health)
	health -= damage_taken
	health_changed.emit()
	if health <= 0:
		print("im ded")
		if owner == Global.player_character:
			Global.dialogue_sequence = Global.death_dialogue
			get_tree().change_scene_to_packed.call_deferred(Global.arcade_scene)
		else:
			owner.queue_free()

# increase health state by specified amount, up to max_health
# returns if health was increased successfully
func _heal_damage(heal: float) -> bool:
	if health < max_health:
		health = minf(health + heal, max_health) # heal up to max_health
		health_changed.emit()
		return true
	return false
