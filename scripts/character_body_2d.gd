extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -4000.0
var fuel = 60000
var distance = 0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle rocket going up                                        .
	if Input.get_axis("ASCEND", "ANTI_ASCEND") and fuel > 0:
			velocity.y = JUMP_VELOCITY
			fuel -= 100
			animated_sprite_2d.animation = &"flying"
	else:
		animated_sprite_2d.animation = &"static"
	if distance < position.y :
		distance = position.y
	print(distance)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
	
	if direction == 1.0 :
		rotation = 0.3
	elif direction == -1.0 :
		rotation = -0.3
	else:
		rotation = 0
	

	move_and_slide()
