extends RigidBody2D




func _on_body_entered(_body: Node) -> void:
	print("thing hjappened")
	queue_free()
