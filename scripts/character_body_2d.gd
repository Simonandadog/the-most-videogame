extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -4000.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ASCEND"):
			velocity.y = JUMP_VELOCITY

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
	
		
		

	if velocity.y <  200:
		animated_sprite_2d.animation = &"flying"
	else:
		animated_sprite_2d.animation = &"static"

	move_and_slide()
