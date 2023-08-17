extends Node

#const rockCubeEntity = preload("res://entities/rock_cube_entity.tscn")
const progName = "Punch"
const progIcon = "res://programs/punch/punch_icon.png"

func executeProgram(Arena):
	var playerTile = Arena.COMBAT_GRID.Player.get_node("../../")
	var coords = playerTile.name.split("")
		#index 1 and 2 for x, y coordinates for player
	print("Punch executing!")
	
	#check for target
	var targetTile = Arena.COMBAT_GRID.combatGrid[int(coords[1])+1][int(coords[2])]
	if targetTile.get_node("tenant").get_child_count() > 0:
		print("Target identified!")
		var target = targetTile.get_node("tenant").get_child(0)
		target.get_node("hpNode").changeHP(-10)
		
		if target.has_node("./mover"):
			target.get_node("mover").moveBy(Vector2(1,0))
		else:
			print("Punch target is NOT movable")
		#TODO: Add punch as a child of player and play animation
		# Attempt damage and push to tile in front of player
		# timeout and delete after
	else:
		print("Nothing is there!")
		
