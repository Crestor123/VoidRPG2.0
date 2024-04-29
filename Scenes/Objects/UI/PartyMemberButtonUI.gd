extends Control

@onready var healthbar = $CenterContainer/VBoxContainer/HealthUI
@onready var equipment = $CenterContainer/VBoxContainer/MarginContainer/EquipmentUI
@onready var button = $CenterContainer/Button
@onready var mainContainer = $CenterContainer

var data : Node = null

signal buttonPressed(data)
signal equipmentSelected(data, equipmentSlot)

func initialize(partyMember : Node, item : Node = null):
	data = partyMember
	healthbar.initialize(partyMember.name, partyMember.stats.getHealthPercent())
	
	if item is EquipmentNode:
		equipment.initialize(partyMember.equipment, item)
	else:
		equipment.initialize(partyMember.equipment, null)
		button.move_to_front()
	equipment.equipmentSelected.connect(equipmentButton)
	

func _on_button_pressed():
	buttonPressed.emit(data)

func equipmentButton(equipmentSlot):
	equipmentSelected.emit(data, equipmentSlot)
