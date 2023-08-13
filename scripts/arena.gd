extends Node2D

var COMBAT_GRID
#COMBAT_GRID also has .Player as a referenced child
var deck = [preload("res://programs/rock_cube/rock_cube.tscn")]
var hand = []
var nextProgramFromDeck = 5

func _ready():
	# shuffle deck and populate hand
	for card in deck:
		hand.push_back(card.instantiate())
	pass

func runProgramFromHand(index):
	print("Running " + hand[0].progName)
	hand[0].executeProgram(self)
	return hand[0]
	#After executing program, return next program to display
	pass
