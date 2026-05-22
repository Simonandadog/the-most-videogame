**Things this language is:**
Unlike C languages, semicolons arent used for terminations, instead new lines are
also, indentations are used for what they are used for. 



# The Main (Default) Functions:
`func _ready():` Is called once when the node its attached to is loaded
`func _process(delta):` is called every frame of the game. delta is the time from something or something.

# Modifying nodes
In the node inspector, you can see what to refrence in there by hovering over stuff. In the code, its refrenced too like this: `$Label.text = "Hello World!"` which takes a label node called Label, and sets the text property to the string "Hello World"  

**Modifying nodes 2.0**
Dragging to the the script editor and holding control while releasing will make a variable with the path to the node. `@onready` is used because Godot generates nodes in a very specific order, and this makes it wait untill all nodes have been generated. 
The $ is actually just a shorthand for `get_node` so ye. 
The paths are reletive to what node they run on.

Paths can be inflexible, and break if you change a node later. Therefore the @export function can be used, looking like `@export var my_node: node`. Then this can be set in the Inspector, with clicking and dragging. If you want for example to only be able to assign sprte type nodes, you can change `node` in there to be `Sprite2D` so it becomes `@export my_node: Sprite2D`
You can check things using the `is` keyword, such as if a node is 2D: `if_ my_node is Node2D`




# Input:
Input actions are managed under project (top bar) > project settings > input map. You can just make keybindings that you can call with this: `func _input(event):` This is another built in fuction of godot that runs whenever an input is pressed. By doing something like: 
```python
func _input(event):
	if event.is_action_pressed("action"):
		$Label.modulate = Color.RED
		
	if event.is_action_released("action"):
		$Label.modulate = Color.GREEN
```
This checks if the action pressed is "action" (is this the most efficent way to do this?) and if it is changes the color of the label to red, and when its released it changes it back to red. Alr mr tutorial man says this is "one of many ways" to handle input in godot, so you in the future should look into that. he has provided a link:
```
https://docs.godotengine.org/en/stable/tutorials/inputs/input_examples.html
```


# Variables:
Variables are containers that hold data. Generally numbers, since puters pute. 
Variables are declared like this: `var name = value` 
They can be changed with `name = value` or have calculations done like
`name = value1 + value2` 
`+= -= *= and /=`  do thier respective calculations to the variable. 

Where you declare a variable is important. A variable declared inside a function can only be used in that function. This is called scope 

Variables in GDScript can be declared without declaring what type of data they hold, And the type of data can even be changed during the operation of the code. (probally not a good idea tho)
There are ofc the 4 data types, **bool, int, float,** and **string** 

changing between data types is called casting, and looks something like this:
```python
var number = 42
var text = "meaning of life: " + str(number)
# text now equals: "meaning of life: 42"

var pi = 3.14
print(int(pi))
# pi is printed as 3 rather than 3.14 in this operation it is not rounded and rather just truncated. 
```

There are also **Vector2** and **Vector3** variables, that store 2 or 3 values. 

Godot is dynamically typed, which means that you can dynamically reassign what type of data a variable is. However, you can statically type whatever you want. 
It is done like this: `var damage: int = 15` which specifies that the variable damage is an integer variable. It is also possible to have Godot infer which type of variable you are using, like this:
`var damage := 15` (called infered typing)

putting `@export` in front of a variable allows it to be set via the inspector. 

The **const** keyword makes a variable that cannot change. Its standard to make your constants in all caps. 

# If Statements (Conditionals)
The main way you do logic while programming. 
`if value comparator value` 

Use the **and** keyword to add more conditions to the statement, which all have to be met, and use the **or** keyword to add more conditions to the statement, but only one of them has to be met. 

You can also use **else** to set what happens if the condition is false, and elif which is else if.


# Functions: 
Functions are easily called reuseable bytes of code. Godot has some built in ones, and if they are prefixed by an underscore, (example: `func _input()`) it means they are not called by the programmer, but rather by the engine. 
syntax for declaring a functions is this: `func name():` and calling it looks like this: `name()` 

Functions can be not only execute code put inside them when called, but also take inputs and give outputs. Inputs are called **Parameters** and outputs are called **Returns**. The code looks like this:
```
func _ready():
	var result = add(3,8)
	print (result)
	result = add(6, 9)
	print (result)
	
func add(num1,num2):
	var result = num1 + num2
	return result
```

To statically type parameters and returns it looks like this:
`func add(num1: int, num2: int) -> int`

# Arrays:
Arrays store sequences of numbers, declared like this: `var numbers []`
Godot has a somewhat unique ability to mix data types in arrays. To statically type one, do this:
`var strings Array[string] = ["yes" "no" "akhgbasriuasrgthoiarewt"` 

To access elements from an array, an index is used. In the above example, "yes" has an index of 0, "no" has an index of 1, and so on. In use it looks like this: `print(strings[0])`. Changing elements is just the same. 

Adding items is done with the **append** keyword. `strings.append("ooga booga")`
Removing items is done with **remove_at**. `strings.remove_at[0]`


# Bröther, may I have some lööps?
Loops. You know em you love em. 
A for loop is done as such:
`for n in m` where n starts at 0, and m is the number to stop at. Translating to C:
`for(int n = 0; n > m; n++)`

While loop repeats as long as a certian condition is met. 
`while value +-<> other_value:` 

The keyword **break** imediately breaks out of the loop, and the keyword **continue** imediately skips to the next iteration of the loop. 



# Dictionaries: 
Dictionaries are like arrays, but each value has a pointer to (can u put an array inside a dictionary? yes and you can layer dictionaries too) They look like this:
`var dictonary {"value_1": 1, "value_2": 2, "value_3": 3, }`
They can also be structured like this:
```
var dictonary {
	"value_1": 1,
	"value_2": 2,
	"value_3": 3,
}
```



# Enums:
A safer way to make states than strings or integers. 

```
enum Alignment {ally, neutral, enemy}
var unit_alignment = Alignment.ally

func _ready()
	if unit_alighment == Alignment.enemy:
		print("fuck off')
	else:
	print("welcome")
```
you can read code. 
They are much more uesfull for exported variables, where you can set a type from a drop down menu in the inspector. Code looks like this: `@export var unit_alignment : Alignment`
Behind the scenes Godot is just creating a constant for each state with increasing numbers. If you try to print one, it will just print its state. You can even override these values:
`enum Alignment {ally = 1, neutral = 0, enemy = -1}`

# Match
This is equivelent to switch from other languages. 
Different code will run depending on the value of a varialble. 'ery nois



# Signals:
In the node tab (next to the inspector) you can have signals, and attach those signals to other nodes by double clicking and connect it to the main script/node. It will put a new function in the node, and there will be a green arrow next to it, which means that a signal is connected to that function. 
You can create them with `signal oonga` (the signal is called oonga) and when you want ot emit it, it looks like `oonga.emit()`
Signals can also be connected through code, with something like `oonga.connect(oonga_func)`(careful about autocompleting parenthesis.) Disconnection can be done just the same with `oonga.disconnect(oonga_func)`
A message/variable can be passed through a signal by putting it as a paremeter everywhere:
```
signal oonga(boonga)
oonga.emit("oonga boonga")
func oonga_func(boonga):
	print(boonga)
```


This is very usefull for decoupling code, for example if a charecter levels up, you can send a signal to change all the different things that need to be changed. 



# Get/Set
Getters and setters allow you to add code for when a variable is changed. 
**Getters:**
This means that we can do things like clamp a value within a certain range or emit a signal letting other parts of the code know that the variable has changed. 
For example, this clamps the health value between 0 and 100
```
var healt := 100:
	set(value):
		health = clamp(value, 0, 100)
```

And if you want to emit a signal that the health has changed:
```
signal health_changed(new_health)

var healt := 100:
	set(value):
		health = clamp(value, 0, 100)
		health_changed.emit(health)
```

**Setters:**
They are commonly used for conversions. An example of this is converting between percentage chance and numeric chance:

```
var chance := 0.2
var chance_pct: int: 
	get:
		return chance * 100
```

Then you can also use a setter here to make sure if you change `chance_pct` it will update `chance` 
```
var chance := 0.2
var chance_pct: int: 
	get:
		return chance * 100
	set(value):
		chance = float(value) / 100.0

```


# Classes (a good one)




# Random: 
**Comments:**
Comments are made with # symbol

**Random numbers:**
Random numbers are easy. for example, a random number from 0-1 can be made with this: 
`var random = randf()`
For a declared integer range it is like this: 
`var random = randi_range(100,200)` which gives a random number from 100 to 200

**Documentation:**
Holding `CTRL` and clicking on a function gives you documentation right in the editor. 
