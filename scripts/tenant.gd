extends Node


func _on_child_entered_tree(node):
	node.position = get_parent().position
