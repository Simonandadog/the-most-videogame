# General:
Godot uses **nodes** as building blocks and containers. 
	the main node in the **scene tree** is the **root** node 
	U should set some scene as the main scene (do this by making the main scene and then just hitting the play button to run the game, and it will give u a lil dialog)
	They should be saved under %game-root%/scenes
In order to see the scene, you need to add a camera object to the main scene (or level ig) node tree




# Charecter (2D):
Charecter movement and physics are created through the node: **CharecterBody2D**
	It should be made as a new scene
	Graphics are made with **sprites**
		They can be animated or not. if they are, you will choose frames through a pretty self explanitory process. 
	 You must make the sprite a phyiscs object with the **Colision Shape 2D** node. This does not need to be very precise. 
Basc player movement is easily made with the default script
To make the camera follow the player, make the camera node a child of the parent node, and turn on camera smoothing if you want camera smoothing to be on.

The player movement script is basic, and we need to modify it for animating the player. 
However, heres what it does before modification. 

```gdscript
extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

```

There are 2 constants called **SPEED** and **JUMP_VELOCITY** (self explanitory)
A variable called **gravity** that defines the gravity from the project settings. 

Start the physics_process() function, which is very similar to the process() function but this runs at a fixed interval (default is 60hz)
	If the player is not on a surface 
		Add gravity
	If the space bar is pressed and the player is on the floor
		Jump
	declare a variable **direction** which is the axis between left and right arrow keys
	if the direction is happening (ig idk wtf is going on)
		the velocity on the x axis = the direction value x the speed value
	otherwise
		the x axis is decreased towards 0
	The function **move_and_slide()** is called for some reason idk what it does prolly something to do with moving and sliding tho

Godot uses an actions system which allows you to bind keys to the actions under 
**Project Settings > Input Map**. This ends up being similar to videogame controls settings 
The ui could be better here imo

after modifying the code to accept my own input actions and sprite flipping it looks like this: 

```gdscript
const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	# Play Animations for running jumping and idle
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else: 
		animated_sprite.play("jump")
	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

```
you can read the fucking code im not writing more code descriptions. 



**Dying:**
the first thing you want to do is limit your camera, which i think i have caused problems with because i made a massive pit. 
To most effectively manage this, you can make your **killzone** be its own scene, with just an **Area2D** node. we use the link button (next to the add button) to add the scene and add the **ColisionShape2D** in the main scene/map/whatever. Then do the same thing as the coins with **on_body_entered** to detect and use in the program. 

```gdscript
@onready var timer = $Timer  
  
func _on_body_entered(body: Node2D) -> void:  
	print("you died.")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()  
  
func _on_timer_timeout() -> void:  
	Engine.time_scale = 1
	get_tree().reload_current_scene()
```

This here code does the following: 
Create a variable **timer** that is linked to a timer node in the killzone tree
When a body enters touches the area of the killzone 
	Print "you died." to console
	Set the timescale of the engine to half of normal
	Delete the **CollisionShape2D** node (so the player falls thru the world)
	Start the timer
When the timer runs out
	Set engine timescale back to realtime
	Reload the scene. 




# World/Enviroment (2D):
The node **StaticBody2D** is used to create static physics objects which are good for things like the ground. 
	The StaticBody2D needs a shape, which is made with **ColisionShape2D**. 
**Tilesets** and **Tilemaps** are used to easily create worlds with by using grid tiles. 
	Tilemaps are created with the node TileMap. The main thing to set correctly is the tile size. 
	In the Tilemap, node, a window at the bottom of the screen will come up, with the and in the Tileset tab of this window you can create and modify the tileset, setting things like bigger tiles and whatnot. 
	You can select multiple tiles at once to pain them all at once. 

**Platforms:**
	They can move and also not move.
	The root node is **AnimatableBody2D**. under that is **Sprite2D** because we need graphics. Under that is **CollisionShape2D** because we need colisions.
	Your sprite sheet might have several things, for this enable region under the Sprite2D node and crop out what you dont need. 
	If the platform needs to be accessed from below, you can turn on one way colisions in the CollisionShape2D node. The direction the arrow is pointing is the direction where there are no collisions. 
	To animate a platform moving back and forth an animation player node is used under the object node. Keyframes are used to do your animation, as in blender. 

**Pickup Truck? no way you're that strong**
	Pickups are made with **Area2D** as the root node. This node dosent have any physics collisions, but it can still detect collisions and use that info for other things. 
	This ofc needs a sprite renderer for what we actually see
	It also needs a CollisionShape2D for detecting the area
	This is where we start doing a little bit of programmin, even tho we havent typed anything at all. 
	In order for the player to interact with a coin, you can go to the signals tab of the Area2D node, and double click what you want. In this case its **on_body_entered()**
	This will cause any and all colisions with the coin (for example a platform) to register a coin hit, but we dont want this, so if we (under the collision tap of the inspector) set the layer on the player to 2, and the mask on the coin to 2, it will fix this issue. 
**Enemies:**
	They hurt
	Use just a base node 2D as the base. The sprite can be animated or not. 
	Because you made your killzone a resueable scene, (you made the killzone a reuseable scene right) it can be used here. 
	Dont forgor to set the animation to autoplay on load. 
	A very simple AI system to move the guy around. 
		The first thing you have to understand is delta, which is a value that changes with the framerate, used to compensate for varrying framerates because the ```func _process ``` function is called once per frame so you have to compensate for that because some people are playing on shitty laptops. 
		the code ``` position.x += 1 *delta ``` will move you 1 pixel per second, which is a bit slow. (figure out how you compensate for differnet screen resolutions.)
		The rule of thumb is when you have a speed value multiply it by delta. 	

So the code we have at this point looks like this:
```gdscript
#extends Node2D  
  
const Speed = 60  
var direction = 1  
  
func _process(delta: float) -> void:  
    position.x += direction * Speed * delta
```
This does the following:
	Gives us a constant **Speed** and sets it equal to 60 for
	Gives us a variable **direction** and sets it equal to 1.
	Then it starts the process loop (the loop that is called once per frame)
		Calls the function position.x and adds the speed variable (variable in pixels basically) multiplied by the direction and the delta (for direction control and equal speed across different framerates.)

after this for like detecting stuff, we need the **Raycast2D** node. We need 2 of them for right and left. He didnt really explain what they do, but ig they kinda just act as colliders but also not???
anyways this is the final code:

```gdscript
extends Node2D

const Speed = 60
var direction = 1

#the thing you cant do automatically cause you just haaad to use an external editor. 
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D



func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	
	position.x += direction * Speed * delta
```
this does the following
	Gives us a constant **Speed** and sets it equal to 60 for
	Gives us a variable **direction** and sets it equal to 1.
	Brings **$RayCastRight** and **RayCastLeft** into the script and sets them equal to thier 
	respective variables.
	brings **$AnimatedSprite2D** into the script and sets it to its variable
	Then it starts the process loop (the loop that is called once per frame)
		Checks if RayCastRight is colliding with something,
			If it is, set direction equal to -1
			Set flip_h to true (basically if the charecter is flipped on the x axis)
		Checks if RayCastLeft is colliding with something
			if it is, set direction equal to 1
			Set flip_h to false (basically if the charecter is flipped on the x axis)
		Calls the function position.x and adds the speed variable (variable in pixels basically) multiplied by the direction and the delta (for direction control and equal speed across different framerates.)

# Text: 
The text can be the ui, or it can be part of the world. mr tutorial man is teaching me how to make it part of the world.
Too add text to the world, the **Label** node is used. At the small scale of the game, it looks kinda ass, so use a pixel font to make it not look ass. 
To change said font, its under **control > theme overrides > fonts**

# Score:
Score is commonly kept through a node called something like **Game Manager**, which can be just a node (not 2d or 3d), because it dosent need any transforms. Then write the code in a script on that node. The script looks like this:
```gdscript
var score = 0

func add_point():
	score +=1
	print(score)
```
it is not best practice to have paths to something higher up in the higherarchy/ backwards down the tree so if you must do something like that and its for a unique object, what you do is right click on the node that you are importing and selecting the option: **Access As Unique Name**.
A limitation of this is only being able to access the thing if its in the same scene. 


# Audio:
The node for audio is **AudioStreamPlayer2D**
Importing an audio stream (js an mp3 file) is simple
The audio tab at the bottom has a fully working audio mixer.
Busses can be done stuff with ig. you route the music to the music bus for example in the node menu place. (inspector)
Remember autoloads. They are scenes but like different
There is a complicated process for sounds before deleting things using animation and shit. 
If you like set the keyframe before changing anything it can have a reset track which is the default thing or something



# Random Stuff:
Godot does texture smoothing by default, for pixel art, disable it with Project > Project Settings > Rendering > Textures > Default Texture Filter  = Linear

**Z INDEXES:** Things are drawn according to thier order in the tree by default, and you can change their order by moving stuff back and forth. However, you dont want to depend on this all the time, so you can change this on (at least some) things (probally mostly bodies) by selecting the root node, going under ordering, and changing the z index value to something higher.

**ADDING THINGS LIKE TIMERS TO THE CODE:** Normally you would add it by clicking and dragging, but because i like to make things more complicated for myself for some reason, i didnt use the inbuilt godot editor. so instead you should do something like this:

	@onready var timer = $Timer
	
this basically adds a variable "timer" that is equal to our timer at the path $Timer
**PATHS** work like this: if we have this path: 
![[Pasted image 20260315120054.png]]
our path to the camera looks like this: 

	$Player/Camera

The root node is the root of whatever scene we are in, and in this example, the timer is part of the scene for the killzone, so the path is just:

	$Timer

So basically the same as filepaths but we ignore the root directory. 


**Orginization**
put stuff in empty nodes to organize it. 
