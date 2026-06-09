extends CharacterBody2D

@export var bullet_scene: PackedScene
@onready var rocket_travel_sound: AudioStreamPlayer2D = $"booster sound"
@onready var laser_shot_sound: AudioStreamPlayer2D = $"laser shot sound"

@onready var timer: Timer = $Timer


const SPEED = 1000.0
const JUMP_VELOCITY = -3000.0
var distance = 0


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



func shoot():
	laser_shot_sound.play()
	var b = bullet_scene.instantiate()
	get_tree().current_scene.add_child(b)  
	b.global_transform = $Muzzle.global_transform
	






func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and position.y < 2000 :
		velocity += get_gravity() * delta

	# Handle rocket going up                                        .
	if Input.get_axis("ASCEND", "ANTI_ASCEND"):
			velocity.y = JUMP_VELOCITY
			animated_sprite_2d.animation = &"flying"	
	else:
		animated_sprite_2d.animation = &"static"
	
	if Input.is_action_just_pressed("ASCEND"):
		rocket_travel_sound.play()
	elif Input.is_action_just_released("ASCEND"):
		rocket_travel_sound.stop()
	
	if distance > position.y :
		distance = position.y
	
	
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
	
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	

	move_and_slide()
