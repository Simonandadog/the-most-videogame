extends RigidBody2D




func _on_body_entered(body: Node) -> void:
	print("thing hjappened")
	queue_free()
