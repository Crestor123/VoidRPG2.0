extends Control

@onready var icon = $MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/Icon
@onready var itemName = $MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/ItemName
@onready var description = $MarginContainer/MarginContainer/VBoxContainer/MarginContainer/Description
@onready var closeButton = $MarginContainer/MarginContainer/VBoxContainer/Container/CloseButton
@onready var equipButton = $MarginContainer/MarginContainer/VBoxContainer/Container/EquipButton

func initialize(item : ItemNode):
	icon.texture = item.icon
	itemName.text = item.itemName
	description.text = item.description
	if item is EquipmentNode:
		equipButton.visible = true
	else: equipButton.visible = false
