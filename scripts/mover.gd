extends Node

var ARENA
@onready var ENTITY = get_parent()
@export var canCohabit = false
@export var teleportEnabled = false
@export var diagonalEnabled = false

func _ready():
	ARENA = get_tree().root.get_node("Arena")

func moveTo(coords: Vector2):
	# if teleport enabled, jump to spot
	var distance = coords - ARENA.getCoords(ENTITY)
#
	if distance.x == 0 and distance.y == 0: return # prevent div by 0 when same tile clicked
	
	var distanceInt = abs(distance.x) + abs(distance.y)
	
	if distanceInt == 1 or validDiagonal(distance, distanceInt):
		moveBy(distance)
	else:
		if abs(distance.y) >= abs(distance.x):
			moveBy(Vector2(0, distance.y / abs(distance.y)))
		else:
			moveBy(Vector2(distance.x / abs(distance.x), 0))
	
	
func moveBy(change: Vector2):
	var pos = ARENA.getCoords(self)
	var targetPos = pos + change
	
	if !validTile(targetPos): return false
	
	var posOccupied = tileOccupied(targetPos)
	if posOccupied and !canCohabit: return false
	
	ARENA.COMBAT_GRID.moveEntity(get_parent(), targetPos.x, targetPos.y)
	
	if posOccupied: runCollision(targetPos)

func validDiagonal(vect, dist):
	return diagonalEnabled and dist == 2 and abs(vect.x) == 1
	
func wrongColor(pos):
	return ARENA.COMBAT_GRID.combatGrid[pos.x][pos.y].red_or_blue != ENTITY.red_or_blue
	
func validTile(pos):
	if pos.x < 0 or pos.x >= 6: return false #invalid x-axis movement
	if pos.y < 0 or pos.y >= 3: return false #invalid y-axis movement
	if ENTITY.name == "Player" and wrongColor(pos): return false
	return true
	
func tileOccupied(pos):
	var target = ARENA.COMBAT_GRID.combatGrid[pos.x][pos.y]
	return target.get_node("tenant").get_child_count() > 0
	
func runCollision(pos):
	var entities = ARENA.COMBAT_GRID.combatGrid[pos.x][pos.y].get_node("tenant").get_children()
	var dmg = mini(entities[0].get_node("hpNode").hp, entities[1].get_node("hpNode").hp)
	
	entities[0].get_node("hpNode").changeHP(-dmg)
	entities[1].get_node("hpNode").changeHP(-dmg)

