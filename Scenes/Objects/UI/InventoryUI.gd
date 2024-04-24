extends Control

@export var itemObject : PackedScene

@onready var itemContainer = $Background/MarginContainer/GridContainer
@onready var backButton = $BackButton

signal buttonPressed(button : String)

func fillItems(itemList : Node):
	emptyItems()
	
	for item in itemList.get_children():
		var newItem = itemObject.instantiate()
		itemContainer.add_child(newItem)
		newItem.initialize(item)
	pass
	
func emptyItems():
	#Remove all items from the grid
	for item in itemContainer.get_children():
		item.queue_free()
	pass

func _on_back_button_pressed():
	buttonPressed.emit("back")
