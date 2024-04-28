extends Node

@export var itemScene : PackedScene
@export var equipmentScene : PackedScene
@export var consumableScene : PackedScene

#Functions that allow for the use of items
func initialize(itemList):
	for item in itemList:
		addItem(item)

func useItem(item : ItemNode, partyMember : PartyMemberNode) -> bool:
	#Use an item on a given party member
	#If the item is a consumable, use it
	var used = false
	
	if item is ConsumableNode:
		if item.targetStat == "health" && item.turns == 1:
			if partyMember.stats.getHealthPercent() == 100:
				return false
			partyMember.stats.takeDamage(-item.bonus, item.element)
			removeItem(item)
			used = true
		else:
			partyMember.stats.addBuff(item.itemName, item.targetStat, item.bonus, item.turns, item.element)
			used = true

	#If the item is equipment, equip it
	if item is EquipmentNode:
		pass
		
	#Otherwise, don't use item
	return used
	pass

func addItem(item : Item):
	var newItem
	if item.stackable:
		for child in get_children():
			if child.data == item && child.quantity < 99:
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

func transferItem(item : ItemNode, destination : Node):
	for child in get_children():
		if item == child:
			destination.add_child(item)
			remove_child(item)

func inInventory(item : ItemNode):
	#Returns if a given item is in the inventory
	for child in get_children():
		if item == child:
			return true
	return false
