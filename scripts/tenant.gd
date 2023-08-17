extends Node


func _on_child_entered_tree(node):
	var targetPos = get_parent().position
#	node.position.move_toward(targetPos, 400)
#	node.position = targetPos
	var tween = create_tween()
	tween.tween_property(node, "position", targetPos, .1)
