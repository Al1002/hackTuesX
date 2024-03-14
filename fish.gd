extends Node3D

var dir : Vector3
var speed : float

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(50)
	speed = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += delta * speed * dir

func _on_wtimer_timeout():
	free()
