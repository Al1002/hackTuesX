extends Node3D

var time : float
var plane_mesh = QuadMesh.new()
@export var scene : PackedScene
@export var spawn_dist : float
@export var group_dist : float
@export var spawn_chance : float
var player

var fish1 = load("res://assets/fauna/tropical_fish.png")
# var fish2 = load("res://assets/fauna/gray_fish.png")
# var fish3 = load("res://assets/fauna/gold_fish.png")


func spawn_fish(pos):
	var new_fish = scene.instantiate()
	
	new_fish.transform.origin = pos
	
	var dir = Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)).normalized()
	
	new_fish.get_node("MeshInstance3D").mesh.material.albedo_texture = fish1
	
	# ?????
	#var rand = randi_range(0, 2)

	#if rand == 0:
		#new_fish.get_node("MeshInstance3D").mesh.material.albedo_texture = fish1
		#
	#elif rand == 1:
		#new_fish.get_node("MeshInstance3D").mesh.material.albedo_texture = fish2
		#
	#elif rand == 2:
		#new_fish.get_node("MeshInstance3D").mesh.material.albedo_texture = fish3

	
	get_node("/root/Main").add_child(new_fish)
	
	new_fish.look_at(dir * 100000)


func spawn_fish_group(group_pos, count):
	for i in range(count):
		var rand_dir = Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)).normalized() * group_dist
		spawn_fish(group_pos + rand_dir)
		

func _ready():
	player = get_node("/root/Main/Player_character")

func _process(delta):
	if randf_range(0, 1) < spawn_chance or Input.is_action_just_pressed("spawn_fish"):
		var rand_dir = Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)).normalized() * spawn_dist
		var spawn_location = player.global_transform.origin + rand_dir
		
		if spawn_location.y > 0:
			return
			
		spawn_fish_group(spawn_location, randi_range(20, 30))
