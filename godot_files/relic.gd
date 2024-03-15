extends Node3D

signal collected

# Called when the node enters the scene tree for the first time
func _ready():
	# Connect the body_entered signal to the on_body_entered function
	connect("body_entered", self._on_area_3d_body_entered)

# Called when the sphere's collision shape enters another collision shape
func _on_area_3d_body_entered(body):
	if body.name == "Player_character":
		emit_signal("collected")
		get_node("/root/Main/Player_character").freze = true
		var ui_text_label = get_node('/root').get_node("Main/UI/TextLabel")
		if ui_text_label:
			ui_text_label.visible = true
		queue_free()
	
