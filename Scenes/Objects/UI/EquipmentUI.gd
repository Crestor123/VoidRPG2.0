extends Control

#Display a list of all equipment slots for a party member

@onready var leftContainer = $HBoxContainer/LeftContainer
@onready var rightContainer = $HBoxContainer/RightContainer

@export var itemIcon : PackedScene

signal equipmentSelected(data)

func initialize(equipmentList : Node, item : EquipmentNode = null):
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
		
		if item == null:
			newIcon.buttonPressed.connect(equipmentButton)
			continue
		if item.slot == "" || item.slot == slot:
			newIcon.buttonPressed.connect(equipmentButton)
		elif item.slot == "ring" && (slot == "rring" || slot == "lring"):
			newIcon.buttonPressed.connect(equipmentButton)
		elif item.slot != slot:
			newIcon.button.visible = false
	pass

func equipmentButton(data):
	equipmentSelected.emit(data)
