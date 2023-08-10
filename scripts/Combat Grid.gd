extends Node2D

const gridOffset = Vector2(50, 200)
var modV = ["aa", "cc", "ee"]
var combatGrid = []

func _ready():
	# Build the grid tiles
	const GridTile = preload("res://grid-tile.tscn")
	
	for x in range(6):
		var newRow = []
		for y in range(3):
			var newGridTile = GridTile.instantiate()
			newGridTile.name = "G" + str(x) + str(y)
			newGridTile.position.x = gridOffset.x + (x * 100)
			newGridTile.position.y = gridOffset.y + (y * 50)
			newGridTile.is_traversable = true
			newGridTile.combatGrid = self
			
			if x < 3:
				newGridTile.red_or_blue = "blue"
				newGridTile.get_node("Polygon2D").modulate = "#0000" + modV[y]
			else:
				newGridTile.red_or_blue = "red"
				newGridTile.get_node("Polygon2D").modulate = modV[y] + "0000"
				
			add_child(newGridTile)
			newRow.push_back(newGridTile)
		combatGrid.push_back(newRow)
		
	#Instantiate Player
	const Player = preload("res://entities/player.tscn")
	var newPlayer = Player.instantiate()
	newPlayer.name = "Player"
	combatGrid[1][0].get_node("tenant").add_child(newPlayer)
	
	#Instantiate Weiner
	const Weiner = preload("res://entities/weiner.tscn")
	var newEnemy = Weiner.instantiate()
	newEnemy.combatGrid = self
	newEnemy.coords = Vector2(5, 0)
	combatGrid[5][0].get_node("tenant").add_child(newEnemy)

func callCombatGrid(grid_space):
	var target = get_tree().get_root().find_child("Player", true, false)
#	print(target)
#	get_tree().get_root().print_tree_pretty()
	if grid_space.red_or_blue == "red":
		print("Player wishes to fire")
	else:
		var prevCoords = target.get_node("../../").name.split("")
		var targetCoords = grid_space.name.split("")
		var changeInX = int(targetCoords[1]) - int(prevCoords[1])
		var changeInY = int(targetCoords[2]) - int(prevCoords[2])
		if changeInX == 0 && changeInY == 0: return
		if abs(changeInY) > abs(changeInX):
			changeInY /= abs(changeInY)
			moveEntity(target, int(prevCoords[1]), int(prevCoords[2]) + changeInY)
		else:
			changeInX /= abs(changeInX)
			moveEntity(target, int(prevCoords[1]) + changeInX, int(prevCoords[2]))
			
		
func moveEntity(entity, x, y):
	entity.get_parent().remove_child(entity) # remove entity from current parent
	combatGrid[x][y].get_node("tenant").add_child(entity) # add to new parent at grid [x][y]
