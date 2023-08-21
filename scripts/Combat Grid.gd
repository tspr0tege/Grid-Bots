extends Node2D

const gridOffset = Vector2(50, 200)
const playerNode = preload("res://entities/player.tscn")

var modV = ["aa", "cc", "ee"]
var combatGrid = []
var Player
var ARENA

func _ready():
	ARENA = get_tree().root.get_node("Arena")
	ARENA.COMBAT_GRID = self
	
	# Build the grid tiles
	const GridTile = preload("res://scenes/grid-tile.tscn")
	
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
#	const Player = preload("res://entities/player.tscn")
	Player = playerNode.instantiate()
	Player.name = "Player"
	combatGrid[1][0].get_node("tenant").add_child(Player)
	
	#Instantiate Weiner
	const Weiner = preload("res://entities/weiner.tscn")
	var newEnemy = Weiner.instantiate()
	newEnemy.COMBAT_GRID = self
#	newEnemy.coords = Vector2(3, 0)
	combatGrid[3][0].get_node("tenant").add_child(newEnemy)
	
#	self.scale = get_viewport_rect().size / Vector2(640, 360)

func handleClick(grid_space):
	var curCoords = ARENA.getCoords(Player)
	
	if grid_space.red_or_blue == "red": #SHOOT
		# TODO: animate firing
		Player.shoot()
		for i in range(curCoords.x + 1, combatGrid.size()):
			if combatGrid[i][curCoords.y].get_node("tenant").get_child_count() > 0:
				var target = combatGrid[i][curCoords.y].get_node("tenant").get_child(0)
				target.get_node("hpNode").changeHP(-10)
				break
	else: #MOVE
		Player.get_node("mover").moveTo(ARENA.getCoords(grid_space.get_child(0)))
			
		
func moveEntity(entity, x, y):
	entity.get_parent().remove_child(entity) # remove entity from current parent
	combatGrid[x][y].get_node("tenant").add_child(entity) # add to new parent at grid [x][y]
