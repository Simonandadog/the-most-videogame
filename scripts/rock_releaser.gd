extends Node2D




func _on_area_2d_body_entered(body: Node2D) -> void:
	print("rock blocker removed")
	print("next stage activated")
	for child in get_children():
		if child is RigidBody2D:
			child.sleeping = false
