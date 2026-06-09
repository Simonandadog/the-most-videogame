extends VisibleOnScreenNotifier2D
@onready var canvas_layer: CanvasLayer = $"../CanvasLayer"



func _on_screen_entered() -> void:
	Engine.time_scale = 0.001
	canvas_layer.visible = true
