extends Node

func playSound():
	var newAudio = get_child(0).duplicate()
	var selfDestruct = Timer.new()
	selfDestruct.set_wait_time(2) # number of seconds between hours
	selfDestruct.autostart = true
	selfDestruct.connect("timeout", func(): newAudio.queue_free())
	newAudio.add_child(selfDestruct)
	self.add_child(newAudio)
	newAudio.play()
