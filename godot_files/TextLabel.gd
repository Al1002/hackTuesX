extends RichTextLabel

# Called when the node enters the scene tree for the first time
func _ready():
	add_text("You picked up an orb!")
	custom_minimum_size = Vector2(200, 50)
	anchor_top = 0.5
	anchor_left = 0.5
	visible = false

# Called every frame
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_node("/root/Main/Player_character").freze = false
		visible = false
