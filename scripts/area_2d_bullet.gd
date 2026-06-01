extends Area2D

var speed = 30000.0  
var startpos = 0


func _on_ready() -> void:
	startpos = self.global_position


func _physics_process(delta):
	position += transform.y * speed * delta * -1
	if global_position.distance_to(startpos) > 40000:
		queue_free()
		print("bullet removed")



func _on_area_entered(area: Area2D) -> void:
	area.queue_free()
	queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	body.queue_free()
	queue_free()
