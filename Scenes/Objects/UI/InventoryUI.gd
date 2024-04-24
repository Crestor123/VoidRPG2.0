extends Control

@export var itemObject : PackedScene

@onready var itemContainer = $Background/MarginContainer/GridContainer
@onready var backButton = $BackButton
@onready var popup = $ItemPopupUI

signal buttonPressed(button : String)
signal equip(selectedItem : EquipmentNode)

var selectedItem : ItemNode = null

func _ready():
	popup.closeButton.pressed.connect(closePopup)
	pass

func fillItems(itemList : Node):
	emptyItems()
	
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

func equipItem():
	pass

func closePopup():
	popup.visible = false

func _on_back_button_pressed():
	buttonPressed.emit("back")
