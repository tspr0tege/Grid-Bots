extends CharacterBody2D

var combatGrid
var is_traversable
var red_or_blue

func _on_button_button_down():
	if (combatGrid):
		combatGrid.handleClick(self)
	else:
		print(self.name)
