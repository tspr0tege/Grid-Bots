extends Control

@onready var ARENA = get_tree().root.get_node("Arena")
@onready var buttons = get_node("MarginContainer/MarginContainer/VBoxContainer").get_children()

func _ready():
	#request programs
	var btnNumber = 0
	var newHand = await ARENA.populateHand()
	for card in newHand:
		buttons[btnNumber].get_node("Sprite2D").set_texture(load(card.progIcon))
		btnNumber +=1

func _on_program_button_down(btn_number):
	btn_number -= 1 #adjust for 0 index
	print("Program number " + str(btn_number) + " clicked!")
	
	# Send execution instruction - returns new card
	var newProg = await ARENA.runProgramFromHand(btn_number)
	
	#newProg .progName .progIcon
	if newProg:
		buttons[btn_number].get_node("Sprite2D").set_texture(load(newProg.progIcon))
	else:
		print("No program available")
#	print(str(buttons[btn_number]))
