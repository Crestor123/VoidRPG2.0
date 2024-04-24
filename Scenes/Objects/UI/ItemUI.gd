extends Control

@onready var button = $PanelContainer/Button
@onready var icon = $TextureRect

signal buttonPressed(data)
var data : Node = null

func initialize(item : ItemNode):
	data = item
	if item.icon != null:
		icon.texture = data.icon

func _on_button_pressed():
	buttonPressed.emit(data)
