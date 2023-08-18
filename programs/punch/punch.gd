extends Node

const progName = "Punch"
const progIcon = "res://programs/punch/punch_icon.png"

func executeProgram(Arena):
	var playerCoords = Arena.getCoords(Arena.COMBAT_GRID.Player)
	
	#check for target
	var targetTile = Arena.COMBAT_GRID.combatGrid[playerCoords.x+1][playerCoords.y]
	if targetTile.get_node("tenant").get_child_count() > 0:
		var target = targetTile.get_node("tenant").get_child(0)
		target.get_node("hpNode").changeHP(-10)
		
		if target.has_node("./mover"):
			target.get_node("mover").moveBy(Vector2(1,0))
	else:
		print("A swing and a MISS!")
		
