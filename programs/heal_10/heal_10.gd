extends Node

const progName = "Heal 10"
const progIcon = "res://programs/heal_10/heal_10.png"

func executeProgram(Arena):
	Arena.COMBAT_GRID.Player.get_node("hpNode").changeHP(10)
#	$audioQueue.playSound()
