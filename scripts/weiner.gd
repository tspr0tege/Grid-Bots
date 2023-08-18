extends CharacterBody2D 

@onready var aniPlayer = get_node("Polygon2D/AnimationPlayer")
@onready var audioQueue = get_node("audioQueue")
var combatGrid
var red_or_blue = "red"
#var coords : Vector2
var dir = Vector2(0, 1)

func _on_move_timer_timeout():
	if ($mover.moveBy(dir) == false):
		dir *= -1
		$mover.moveBy(dir)

func takeDamage():
	aniPlayer.play("flash")
	audioQueue.playSound()
	
func zeroHP():
	self.queue_free()
	print("Weiner destroyed!")
