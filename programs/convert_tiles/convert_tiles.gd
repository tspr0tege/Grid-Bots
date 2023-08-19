extends Node

const progName = "Convert Tiles"
const progIcon = "res://programs/convert_tiles/convert_tiles_icon.png"

const modV = ["aa", "cc", "ee"]

func executeProgram(ARENA):
	# Find the first hostile tile
	var gridArray = ARENA.COMBAT_GRID.combatGrid
	var player = ARENA.COMBAT_GRID.Player
	var targetCol
	for col in gridArray:
		if targetCol: break
		for tile in col:
			if tile.red_or_blue != player.red_or_blue:
				targetCol = ARENA.getCoords(tile).x
				print("Tile to convert, found at: " + str(targetCol))
				break
	
	for tile in gridArray[targetCol]:
		convertTile(tile, "blue", ARENA.getCoords(tile))

func convertTile(tile, color, coords):
	if tile.get_node("tenant").get_child_count() > 0:
		tile.get_node("tenant").get_child(0).get_node("hpNode").changeHP(-10)
	else:
		tile.red_or_blue = "blue"
		tile.get_node("Polygon2D").modulate = "#0000" + modV[coords.y]
#		if x < 3:
#				newGridTile.red_or_blue = "blue"
#				newGridTile.get_node("Polygon2D").modulate = "#0000" + modV[y]
#			else:
#				newGridTile.red_or_blue = "red"
#				newGridTile.get_node("Polygon2D").modulate = modV[y] + "0000"
