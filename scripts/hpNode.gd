extends Control

@export var maxHP = 666
@onready var hp = maxHP
@onready var hpDisplay = get_node("hpDisplay")

func _ready():
	hpDisplay.text = str(hp)

func changeHP(amt):
	hp += amt
	if amt < 0:	get_parent().takeDamage()
	if hp > maxHP: hp = maxHP
	if hp <= 0: 
		hp = 0
		get_parent().zeroHP()
	hpDisplay.text = str(hp)
