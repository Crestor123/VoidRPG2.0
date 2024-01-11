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
	for item in targets:
		var button = Button.new()
		add_child(button)
		button.flat = true
		button.global_position.x = item.global_position.x
		button.global_position.y = item.global_position.y
		button.size = item.sprite.get_size()
		button.pressed.connect(self.buttonPressed)
		
	currentTarget = targets[0]
	moveCursor(get_child(0))
	pass

func disable():
	visible = false
	for item in get_children():
		item.queue_free()
		
	targets.clear()
	currentTarget = null

func moveCursor(button : Node):
	global_position.y = button.global_position.y
	global_position.x = button.global_position.x
	var index = 0
	pass

func buttonPressed():
	pass
