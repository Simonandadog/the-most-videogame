extends Area2D
@onready var explosion: AudioStreamPlayer2D = $AudioStreamPlayer2D

var speed = 30000.0  

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	print("bullet removed")


func _physics_process(delta):
	position += transform.y * speed * delta * -1

func _on_area_entered(area: Area2D) -> void:
	explosion.play()
	area.queue_free()
	queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	explosion.play()
	body.queue_free()
	queue_free()
