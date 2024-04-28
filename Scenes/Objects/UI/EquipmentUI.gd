extends Control

#Display a list of all equipment slots for a party member

@onready var leftContainer = $HBoxContainer/LeftContainer
@onready var rightContainer = $HBoxContainer/RightContainer

@export var itemIcon : PackedScene

signal equipmentSelected()

func initialize(equipmentList : Node):
	var slots = equipmentList.slots
	for slot in slots:
		var newIcon = itemIcon.instantiate()
		if slot in ["head", "body", "legs", "feet"]:
			leftContainer.add_child(newIcon)
		else:
			rightContainer.add_child(newIcon)
		if slots[slot] != null:
			newIcon.initialize(slots[slot])
		else: newIcon.data = slot
	pass
