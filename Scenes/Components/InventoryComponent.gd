extends Node

@export var itemScene : PackedScene
@export var equipmentScene : PackedScene
@export var consumableScene : PackedScene

@export var parent : Node

#Functions that allow for the use of items
func initialize(itemList):
	parent = get_parent()
	for item in itemList:
		addItem(item)

func useItem(item : Item):
	pass

func addItem(item : Item):
	var newItem
	if item is Consumable:
		newItem = consumableScene.instantiate()
	elif item is Equipment:
		newItem = equipmentScene.instantiate()
	else:
		newItem = itemScene.instantiate()
		
	add_child(newItem)
	newItem.data = item
	newItem.initialize()
	pass
