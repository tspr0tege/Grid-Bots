extends Node2D

func takeDamage():
#	aniPlayer.play("flash")
#	audioQueue.playSound()
	pass
	
func zeroHP():
	self.queue_free()
	print("Rock Cube destroyed!")
