extends CharacterBody2D 

@onready var aniPlayer = get_node("Polygon2D/AnimationPlayer")
@onready var audioQueue = get_node("audioQueue")
var COMBAT_GRID
var red_or_blue = "red"
var dir = Vector2(0, 1)

func _on_move_timer_timeout():
	var ARENA = get_tree().root.get_node("Arena")
	var PLAYER = COMBAT_GRID.Player
	var playerPos = ARENA.getCoords(PLAYER)
	var myPos = ARENA.getCoords(self)
	
	if (myPos.y == playerPos.y): # Attack
		audioQueue.playSound("pew")
		for i in range(myPos.x-1, -1, -1):
			var tile = COMBAT_GRID.combatGrid[i][myPos.y].get_node("tenant")
			if (tile.get_child_count() > 0):
				tile.get_child(0).get_node("hpNode").changeHP(-10)
				break
		
	elif ($mover.moveBy(dir) == false): # Move
		dir *= -1
		$mover.moveBy(dir)

func takeDamage():
	aniPlayer.play("flash")
	audioQueue.playSound("hit")
	
func zeroHP():
	self.queue_free()
	print("Weiner destroyed!")
