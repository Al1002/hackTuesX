extends Node3D

var dir : Vector3
var speed : float
var camera


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(5)
	speed = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera = get_node("/root/Main/Player_character/SpringArm3D/Camera3D")
	
	look_at(camera.global_transform.origin)
	# rotate_object_local(camera.transform.origin, 90)
	

func _on_timer_timeout():
	queue_free()
