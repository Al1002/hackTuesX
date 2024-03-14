extends Node3D

@export var spawning_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = 1
	$Timer.autostart = true
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn():
	var spawned = spawning_scene.instantiate()
	var dir = Vector3(randf_range(-1,1),randf_range(-1,1),randf_range(-1,1)).normalized()
	spawned.position = self.global_position
	add_child(spawned)
	spawned.dir = dir
	return spawned

func spawn_school():
	pass



func _on_timer_timeout():
	spawn()
