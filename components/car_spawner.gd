class_name CarSpawner
extends Node2D

var timer: Timer

@export_enum("Left", "Right") var direction: int = 0

var spawn_burst: int = 0

func _ready() -> void:
	timer = Timer.new()
	timer.timeout.connect(_spawn_timer)
	add_child(timer)
	timer.start(randf_range(0.75, 1.5))
	spawn_burst = randi_range(1, 3)
	

func _spawn_timer() -> void:
	var car_inst: Node2D = Global.car.instantiate()
	add_child(car_inst)
	car_inst.direction = direction
	spawn_burst -= 1
	
	if spawn_burst > 0:
		timer.start(randf_range(0.1, 0.3))
	else:
		timer.start(randf_range(0.75, 1.5))
		spawn_burst = randi_range(1, 3)
