extends Control

@onready var buttonContainer = $ButtonContainer

@export var partyMemberButton : PackedScene

var destination : Node = null
var selectedItem : Node = null
var equipmentMode : bool = false
signal partySelected(partyMember : Node)
signal equipmentSelected(partyMember : Node, equipmentSlot : String)

func initialize(partyList : Array, caller : Node, equipMode : bool = false):
	if destination == caller: return
	visible = true
	equipmentMode = equipMode
	
	destination = caller
	if destination.has_method("partyMemberSelected"):
		partySelected.connect(destination.partyMemberSelected)
		
	if destination.has_method("equipmentSelected"):
		equipmentSelected.connect(destination.equipmentSelected)
	
	if destination.has_method("getSelectedItem"):
		selectedItem = destination.getSelectedItem()
	
	for partyMember in partyList:
		var newButton = partyMemberButton.instantiate()
		buttonContainer.add_child(newButton)
		newButton.initialize(partyMember, selectedItem, equipMode)
		newButton.buttonPressed.connect(partyMemberSelected)
		newButton.equipmentSelected.connect(equipmentSlotSelected)
	pass

func refresh(partyList : Array):
	for item in buttonContainer.get_children():
		item.queue_free()
		
	for partyMember in partyList:
		var newButton = partyMemberButton.instantiate()
		buttonContainer.add_child(newButton)
		newButton.initialize(partyMember, selectedItem, equipmentMode)
		newButton.buttonPressed.connect(partyMemberSelected)
		newButton.equipmentSelected.connect(equipmentSlotSelected)

func partyMemberSelected(partyMember : Node):
	print(partyMember, " selected")
	partySelected.emit(partyMember)
	cancel()

func equipmentSlotSelected(partyMember : Node, equipment, equipmentSlot):
	print(partyMember, "'s ", equipmentSlot, " selected")
	equipmentSelected.emit(partyMember, equipment, equipmentSlot)
	if equipmentMode == false:
		cancel()
	pass

func cancel():
	visible = false
	for item in buttonContainer.get_children():
		item.queue_free()
	
	if destination == null: return
	if destination.has_method("partyMemberSelected"):
		partySelected.disconnect(destination.partyMemberSelected)
		equipmentSelected.disconnect(destination.partyMemberSelected)
	destination = null
	selectedItem = null
