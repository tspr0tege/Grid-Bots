extends Node

const rockCubeEntity = preload("res://entities/rock_cube_entity.tscn")
const progName = "Rock Cube"
const progIcon = "res://programs/rock_cube/rock_cube_icon.png"

func executeProgram(Arena):
	var pos = Arena.getCoords(Arena.COMBAT_GRID.Player)
		#index 1 and 2 for x, y coordinates
	
	var targetGridTile = Arena.COMBAT_GRID.combatGrid[pos.x+1][pos.y].get_node("tenant")
	
	var newCube = rockCubeEntity.instantiate()
	targetGridTile.add_child(newCube)
	
	if targetGridTile.get_child_count() > 1: 
		var timer = Timer.new()
		timer.autostart = true
		timer.one_shot = true
		timer.set_wait_time(0.1)
		timer.connect("timeout", func ():
			newCube.get_node("mover").runCollision(Vector2(pos.x+1, pos.y))
		)
		newCube.add_child(timer)
