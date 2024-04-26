extends Node

@export var itemScene : PackedScene
@export var equipmentScene : PackedScene
@export var consumableScene : PackedScene

#Functions that allow for the use of items
func initialize(itemList):
	for item in itemList:
		addItem(item)

func useItem(item : ItemNode):
	pass

func addItem(item : Item):
	var newItem
	if item is Consumable:
		for child in get_children():
			if child.data == item:
				child.quantity += 1
				return
		newItem = consumableScene.instantiate()
	elif item is Equipment:
		newItem = equipmentScene.instantiate()
	else:
		newItem = itemScene.instantiate()
		
	add_child(newItem)
	newItem.data = item
	newItem.initialize()
	pass

func removeItem(item : ItemNode):
	for child in get_children():
		if item == child:
			if item is ConsumableNode && item.quantity > 1:
				item.quantity -= 1
			else:
				item.queue_free()

func inInventory(item : ItemNode):
	#Returns if a given item is in the inventory
	for child in get_children():
		if item == child:
			return true
	return false
