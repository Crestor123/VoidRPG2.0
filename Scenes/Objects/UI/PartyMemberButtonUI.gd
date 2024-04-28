extends Control

@onready var healthbar = $CenterContainer/VBoxContainer/HealthUI
@onready var equipment = $CenterContainer/VBoxContainer/MarginContainer/EquipmentUI
@onready var button = $CenterContainer/Button

var data : Node = null

signal buttonPressed(data)

#TODO: Figure out button layering; different modes based on what input is expected?

func initialize(partyMember : Node):
	data = partyMember
	healthbar.initialize(partyMember.name, partyMember.stats.getHealthPercent())
	equipment.initialize(partyMember.equipment)

func _on_button_pressed():
	buttonPressed.emit(data)
