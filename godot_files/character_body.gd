extends CharacterBody3D


const SPEED = 10
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var freze : bool

@onready var spring_arm = $SpringArm3D

@export var mouse_sensitivity = 0.0030

enum {
	MOVING,
	IDLE,
	JUMPING
}

var animation_state = IDLE

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$BubbleParticleSystem.emitting = true
	freze = false

func _unhandled_input(event):
	if freze == true:
		return
	if event is InputEventMouseMotion:
		rotation.x -= event.relative.y * mouse_sensitivity
		rotation.y -= event.relative.x * mouse_sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -30.0, 30.0)
		spring_arm.rotation_degrees.x = rotation_degrees.x / 2

func _process(delta):
	if freze == true:
		return
	if Input.is_action_pressed("key_exit"):
		get_tree().quit()
	if animation_state == IDLE:
		$character/AnimationPlayer.play("treading")
	elif animation_state == MOVING:
		$character/AnimationPlayer.play("swimming")

func _physics_process(delta):
	if freze == true:
		velocity = Vector3(0,0,0)
		return
	if  position.x > 100 or position.z > 100 or position.x < -100 or position.z < -100: # invisible wall
		position=Vector3(0,-10,0)
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		$SandParticleSystem.emitting = false
	
	if is_on_floor():
		$SandParticleSystem.emitting = true

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		
		var randnum = randi_range(1,3)
		if randnum == 1:
			$SwimSound.play()
		if randnum == 2:
			$SwimSound2.play()
		if randnum == 3:
			$SwimSound3.play()
	
	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		$character.look_at(position+direction) # turn into lerp later
		animation_state = MOVING
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		animation_state = IDLE
	
	move_and_slide()

