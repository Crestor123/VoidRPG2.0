extends Control

@onready var button = $Button
@onready var label = $PanelContainer/MarginContainer/HBoxContainer/Label
@onready var icon = $PanelContainer/MarginContainer/HBoxContainer/MarginContainer/Icon

signal buttonPressed(data)
var data : Node = null

func initialize(ability : Node):
	data = ability
	icon.texture = ability.icon
	label.text = ability.abilityName
	pass

func _on_button_pressed():
	buttonPressed.emit(data)
