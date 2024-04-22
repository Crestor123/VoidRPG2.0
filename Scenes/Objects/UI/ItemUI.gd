extends Control

@onready var button = $PanelContainer/Button
@onready var icon = $PanelContainer/TextureRect

signal buttonPressed(data)
var data : Node = null

func initialize(item : Node):
	data = item
	if item.icon != null:
		icon.texture = data.icon
