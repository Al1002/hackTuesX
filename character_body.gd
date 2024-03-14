extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var spring_arm = $SpringArm3D
@onready var jump_audio = $AudioStreamPlayer

@export var mouse_sensitivity = 0.0015

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$BubbleParticleSystem.emitting = true

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation.x -= event.relative.y * mouse_sensitivity
		rotation.y -= event.relative.x * mouse_sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -30.0, 30.0)
		spring_arm.rotation_degrees.x = rotation_degrees.x
		


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		$SandParticleSystem.emitting = false
	
	if is_on_floor():
		$SandParticleSystem.emitting = true

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		jump_audio.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
