extends Control

@onready var healthbar = $CenterContainer/HealthUI
@onready var button = $CenterContainer/Button

var data : Node = null

signal buttonPressed(data)

func initialize(partyMember : Node):
	data = partyMember
	healthbar.initialize(partyMember.name, partyMember.stats.getHealthPercent())

func _on_button_pressed():
	buttonPressed.emit(data)
