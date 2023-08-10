extends Sprite2D

@onready var aniPlayer = get_node("Polygon2D/AnimationPlayer")
@onready var audioQueue = get_node("audioQueue")
var combatGrid
var coords : Vector2
var dir = 1

func _on_move_timer_timeout():
#	print("Moving")
	if coords.y + dir < 0 || coords.y + dir >= combatGrid.combatGrid[coords.x].size():
#		print("changing direction")
		dir *= -1
	coords.y += dir
	combatGrid.moveEntity(self, coords.x, coords.y)

func takeDamage():
	aniPlayer.play("flash")
	audioQueue.playSound()
	
func zeroHP():
	self.queue_free()
	print("Weiner destroyed!")
