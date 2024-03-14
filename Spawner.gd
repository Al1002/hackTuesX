extends Node3D

@export var spawning_scene : PackedScene
var spawnPoint : Vector3
var spawnRadius : float = 50
var rotationSpeed : float = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = 1
	$Timer.autostart = true
	$Timer.start()
	spawnPoint = position


func spawn():
	var spawned = spawning_scene.instantiate()
	
	# Set initial position of the fish to be on the circle
	var angle = randf_range(0, 360)
	var radians = deg_to_rad(angle)
	var xOffset = spawnPoint.x + spawnRadius * cos(radians)
	var zOffset = spawnPoint.z + spawnRadius * sin(radians)
	spawned.position = Vector3(xOffset, randf_range(-1,1), zOffset)
	
	# Add fish to the scene
	add_child(spawned)

func _process(delta):
	for child in get_children():
		if child is Timer:
			break
		var pos = child.position - spawnPoint
		var new_pos = Vector3(pos.x * cos(rotationSpeed * delta) - pos.z * sin(rotationSpeed * delta),pos.x * sin(rotationSpeed * delta) + pos.z * cos(rotationSpeed * delta),pos.y)
		child.position = spawnPoint + new_pos

func _on_timer_timeout():
	spawn()
