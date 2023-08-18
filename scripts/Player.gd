extends CharacterBody2D

var red_or_blue = "blue"

func shoot():
	$audioQueue.playSound()
#	$shotParticles.restart()
#	$shotParticles.set_emitting(true)

func takeDamage():
	pass
	
func zeroHP():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("ui_left"):
		$mover.moveBy(Vector2(-1, 0))
	if Input.is_action_just_pressed("ui_right"):
		$mover.moveBy(Vector2(1, 0))
	if Input.is_action_just_pressed("ui_up"):
		$mover.moveBy(Vector2(0, -1))
	if Input.is_action_just_pressed("ui_down"):
		$mover.moveBy(Vector2(0, 1))
		
