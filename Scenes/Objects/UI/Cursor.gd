extends TextureRect

#When given a list of nodes, creates buttons over them that move the cursor when pressed
#Can be polled to determine the currently targeted node

@export var targets : Array[Node]

var currentTarget : Node = null

signal targetChanged(target)

func _ready():
	if targets:
		initialize(targets)

func initialize(targetList : Array[Node]):
	visible = true
	
	targets = targetList
	#for item in targets:
		#var button = Button.new()
		#add_child(button)
		#button.flat = true
		#button.global_position.x = item.global_position.x
		#button.global_position.y = item.global_position.y
		#button.global_position = item.global_position
		#button.size = item.sprite.get_size()
		#button.pressed.connect(self.buttonPressed)
		
	currentTarget = targets[0]
	moveCursor(currentTarget)
	pass

func disable():
	visible = false
	for item in get_children():
		item.queue_free()
		
	targets.clear()
	currentTarget = null

func moveCursor(target : Node):
	global_position = target.global_position
	global_position.x += (target.size.x / 2) - (size.x / 2)
	global_position.y += target.size.y
	#global_position.y = button.global_position.y
	#global_position.x = button.global_position.x
	#var index = 0
	currentTarget = target
	pass

func buttonPressed():
	pass
