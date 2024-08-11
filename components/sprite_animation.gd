class_name SpriteAnimation
extends Node

@export var body: CharacterBody2D
@export var sprite: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# work with sprites
	if body.velocity != Vector2.ZERO:
		sprite.play(&"run")
		var x_dir: int = sign(body.velocity.x)
		if x_dir != 0:
			sprite.scale = Vector2(sign(body.velocity.x), 1)
	else:
		sprite.play(&"idle")
