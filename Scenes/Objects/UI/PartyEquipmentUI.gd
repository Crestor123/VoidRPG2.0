extends Control

@onready var partySelector = $VBoxContainer/ColorRect/PartySelectorUI
@onready var itemPopup = $ItemPopupUI
@onready var backButton = $VBoxContainer/BackButton

var party : Node = null
var selectedParty : Node = null
var selectedItem : EquipmentNode = null

signal equipmentSlot(partyMember : Node, equipmentSlot : String)
signal buttonPressed(button : String)
signal cancelEquip()

func _ready():
	partySelector.equipmentSelected.connect(equipmentSelected)
	itemPopup.closeButton.pressed.connect(closePopup)
	itemPopup.useButton.pressed.connect(unequip)

func initialize(partyList : Node):
	party = partyList
	partySelector.initialize(party.get_children(), self, true)
	
	pass

func equipmentSelected(partyMember : Node, equipment : EquipmentNode, equipmentSlot : String):
	if equipment == null: return
	selectedParty = partyMember
	selectedItem = equipment
	itemPopup.initialize(equipment)
	itemPopup.visible = true
	pass

func empty():
	itemPopup.visible = false
	partySelector.cancel()

func unequip():
	if selectedItem == null: return
	if selectedParty == null: return
	
	var used = false
	used = selectedParty.equipment.unequip(selectedItem)
	if used:
		partySelector.refresh(party.get_children())
		closePopup()
	pass

func closePopup():
	selectedParty = null
	selectedItem = null
	itemPopup.visible = false
	pass

func _on_back_button_pressed():
	empty()
	buttonPressed.emit("back")
