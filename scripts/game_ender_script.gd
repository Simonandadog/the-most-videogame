extends VisibleOnScreenNotifier2D



func _on_screen_entered() -> void:
	Engine.time_scale = 0.001
