extends Node2D




func _on_area_2d_body_entered(body: Node2D) -> void:
	print("rock blocker removed")
	$StaticBody2D/CollisionShape2D.queue_free()
	$StaticBody2D.queue_free()
	$Area2D/CollisionShape2D.queue_free()
	$Area2D.queue_free()
	queue_free()
