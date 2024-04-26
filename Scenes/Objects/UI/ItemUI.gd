extends Control

@onready var button = $CenterContainer/TextureRect/Button
@onready var icon = $CenterContainer/TextureRect
@onready var quantity = $CenterContainer/TextureRect/Quantity

signal buttonPressed(data)
var data : Node = null

func initialize(item : ItemNode):
	data = item
	if item.icon != null:
		icon.texture = data.icon
	if item is ConsumableNode:
		quantity.visible = true
		quantity.text = str(item.quantity)

func _on_button_pressed():
	buttonPressed.emit(data)
