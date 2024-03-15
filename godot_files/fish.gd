extends Node3D

var time : float
@export var speed : float
var camera

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera = get_node("/root/Main/Player_character/SpringArm3D/Camera3D")
	
	look_at(camera.global_transform.origin)
	# rotate_object_local(camera.transform.origin, 90)
	
func _physics_process(delta):
	time += delta
	
	transform.origin += global_transform.basis.z * speed * delta
	

func _on_timer_timeout():
	queue_free()
