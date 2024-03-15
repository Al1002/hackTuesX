extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(randf_range(60, 120))
	self.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_timer_timeout():
	self.play()
	$Timer.start(randf_range(120, 360))
