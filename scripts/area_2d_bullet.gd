extends Area2D

var speed = 30000.0  

func _physics_process(delta):
	position += transform.y * speed * delta * -1

func _on_Bullet_body_entered(body):
	if body.is_in_group("rocks"):
		body.queue_free()
	queue_free()
