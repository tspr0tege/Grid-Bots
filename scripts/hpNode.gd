extends Control

@export var hp = 666
@onready var hpDisplay = get_node("hpDisplay")

func _ready():
	hpDisplay.text = str(hp)

func changeHP(amt):
	hp += amt
	if amt < 0:	get_parent().takeDamage()
	if hp <= 0: 
		hp = 0
		get_parent().zeroHP()
	hpDisplay.text = str(hp)
