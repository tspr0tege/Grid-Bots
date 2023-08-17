extends Node

@export var canCohabit = false
var ARENA

func _ready():
	ARENA = get_tree().root.get_node("Arena")

func moveTo(coords: Vector2):
	# Attempts to move to a specific tile
	print("moving to: " + str(ARENA.COMBAT_GRID.combatGrid[coords.x][coords.y]))
	
func moveBy(change: Vector2):
	var pos = ARENA.getCoords(self)
	var targetPos = pos + change
	
	if !validTile(targetPos): return false
	
	var posOccupied = tileOccupied(targetPos)
	if posOccupied && !canCohabit: return false
	
	ARENA.COMBAT_GRID.moveEntity(get_parent(), targetPos.x, targetPos.y)
	
	if posOccupied: runCollision(targetPos)

func validTile(pos):
	if pos.x < 0 || pos.x >= 6: return false #invalid x-axis movement
	if pos.y < 0 || pos.y >= 3: return false #invalid y-axis movement
	return true
	
func tileOccupied(pos):
	var target = ARENA.COMBAT_GRID.combatGrid[pos.x][pos.y]
	return target.get_node("tenant").get_child_count() > 0
	
func runCollision(pos):
	var entities = ARENA.COMBAT_GRID.combatGrid[pos.x][pos.y].get_node("tenant").get_children()
	var dmg = mini(entities[0].get_node("hpNode").hp, entities[1].get_node("hpNode").hp)
	
	entities[0].get_node("hpNode").changeHP(-dmg)
	entities[1].get_node("hpNode").changeHP(-dmg)

