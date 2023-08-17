extends Node2D

var COMBAT_GRID
#COMBAT_GRID also has .Player as a referenced child
var deck = [
	preload("res://programs/rock_cube/rock_cube.tscn"),
	preload("res://programs/punch/punch.tscn"),
]
var hand = []
var nextProgramFromDeck = 5

func _ready():
	# TODO: shuffle deck and populate hand
	pass
	
func getCoords(entity):
	var parentTile = entity.find_parent("G*")
	var nameArray = parentTile.name.split("")
	
	return 	Vector2(int(nameArray[1]), int(nameArray[2]))
	
func populateHand():
	for card in deck:
		hand.push_back(card.instantiate())
		
	print("hand populated")
	
	return hand

func runProgramFromHand(index):
#	print("Running " + hand[0].progName)
	if index >= hand.size(): return
	
	hand[index].executeProgram(self)
	
	#TODO: grab next program from deck, increment "nextProgram", place program in hand[index]
	
	return hand[index]
