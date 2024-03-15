extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(randf_range(30, 90))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var randnum = randi_range(0,1)

	if randnum == 0:
		$AmbientSound.play()
	if randnum == 1:
		$UnderwaterAmbience.play()
	
	$Timer.start(randf_range(180, 450))
