extends Sprite2D

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
