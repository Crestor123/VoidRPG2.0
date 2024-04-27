extends Control

@export var itemObject : PackedScene

@onready var itemContainer = $Background/MarginContainer/GridContainer
@onready var backButton = $BackButton
@onready var popup = $ItemPopupUI

signal buttonPressed(button : String)
signal use()	#Emits self

var inventory : Node = null
var selectedItem : ItemNode = null

func _ready():
	popup.visible = false
	
	popup.closeButton.pressed.connect(closePopup)
	popup.useButton.pressed.connect(useItem)
	pass

func fillItems(itemList : Node):
	inventory = itemList
	emptyItems()
	
	popup.visible = false
	if selectedItem != null:
		popup.initialize(selectedItem)
		popup.visible = true
	
	for item in itemList.get_children():
		var newItem = itemObject.instantiate()
		itemContainer.add_child(newItem)
		newItem.buttonPressed.connect(itemButtonPressed)
		newItem.initialize(item)
	pass
	
func emptyItems():
	#Remove all items from the grid
	for item in itemContainer.get_children():
		item.queue_free()
	pass

func itemButtonPressed(item : ItemNode):
	selectedItem = item
	popup.initialize(item)
	popup.visible = true

func useItem():
	if selectedItem != null:
		use.emit(self)
	else: print("Selected item is null")
	pass

func partyMemberSelected(partyMember : Node):
	var used = inventory.useItem(selectedItem, partyMember)
	if used:
		fillItems(inventory)
	else:
		#Popup: item could not be used
		pass
	pass

func closePopup():
	selectedItem = null
	popup.visible = false

func _on_back_button_pressed():
	emptyItems()
	buttonPressed.emit("back")
