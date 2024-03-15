extends Node3D

var plane_mesh = QuadMesh.new()
@export var scene : PackedScene
@export var spawn_dist : float
@export var group_dist : float
var player

var fishes = [
		load("res://assets/fauna/blue_fish.png"),
		load("res://assets/fauna/gold_fish.png"),
		load("res://assets/fauna/gray_fish.png"),
		load("res://assets/fauna/orange_fish.png"),
		load("res://assets/fauna/tropical_fish.png")
	]


func spawn_fish(pos, fish_type):
	var new_fish = scene.instantiate()
	
	new_fish.transform.origin = pos
	new_fish.get_child(0).mesh.material.albedo_texture = fish_type
	
	get_node("/root/Main").add_child(new_fish)


func spawn_fish_group(group_pos, count, fish_type):
	for i in range(count):
		var rand_dir = Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)).normalized() * group_dist
		spawn_fish(group_pos + rand_dir, fishes[fish_type])
		

func _ready():
	player = get_node("/root/Main/Player_character")
	

func _process(delta):
	if Input.is_action_just_pressed("spawn_fish"):
		var rand_dir = Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)).normalized() * spawn_dist
		spawn_fish_group(player.global_transform.origin + rand_dir, randi_range(10, 15), randi_range(0, 4))
	
