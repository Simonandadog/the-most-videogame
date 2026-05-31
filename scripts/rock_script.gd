extends RigidBody2D

var scalecomponent =  randf_range(0.2,1)
var myscale = Vector2(scalecomponent,scalecomponent)
var myrotation = randi_range(0,360) 

func _on_ready() -> void:
	$".".scale = myscale
	$".".rotation_degrees = myrotation
