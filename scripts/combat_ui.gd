extends Control

@onready var ARENA = get_tree().root.get_node("Arena")

func _on_program_button_down(btn_number):
	print("Program number " + str(btn_number) + " clicked!")
	btn_number -= 1 #adjust for 0 index
	var newProg = await ARENA.runProgramFromHand(btn_number)
	
	#newProg .progName .progIcon
	var buttons = get_node("MarginContainer/MarginContainer/VBoxContainer").get_children()
	buttons[btn_number].get_node("Sprite2D").set_texture(load(newProg.progIcon))
#	print(str(buttons[btn_number]))
