extends Control

@onready var healthbar = $CenterContainer/VBoxContainer/HealthUI
@onready var equipment = $CenterContainer/VBoxContainer/MarginContainer/EquipmentUI
@onready var button = $CenterContainer/Button
@onready var mainContainer = $CenterContainer

var data : Node = null

signal buttonPressed(data)
signal equipmentSelected(data, equipmentSlot)

#TODO: Figure out button layering; different modes based on what input is expected?

func initialize(partyMember : Node, item : Node = null):
	data = partyMember
	healthbar.initialize(partyMember.name, partyMember.stats.getHealthPercent())
	equipment.initialize(partyMember.equipment, item)
	equipment.equipmentSelected.connect(equipmentButton)
	
	if item == null:
		button.move_to_front()

func _on_button_pressed():
	buttonPressed.emit(data)

func equipmentButton(equipmentSlot):
	equipmentSelected.emit(data, equipmentSlot)
