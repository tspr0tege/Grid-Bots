extends Node

const rockCubeEntity = preload("res://entities/rock_cube_entity.tscn")
const progName = "Rock Cube"
const progIcon = "res://programs/rock_cube/rock_cube_icon.png"

func testFunc():
	print("Rock Cube has been touched!")
	
func executeProgram(Arena):
#	var Arena = get_tree().root.get_node("Arena")
	var pos = Arena.COMBAT_GRID.Player.get_node("../../").name.split("") 
		#index 1 and 2 for x, y coordinates
	
	var targetGridTile = Arena.COMBAT_GRID.combatGrid[int(pos[1])+1][int(pos[2])]
	
	var newCube = rockCubeEntity.instantiate()
	#combatGrid[1][0].get_node("tenant").add_child(Player)
	targetGridTile.get_node("tenant").add_child(newCube)
