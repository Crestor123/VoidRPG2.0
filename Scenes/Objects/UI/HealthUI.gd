extends MarginContainer

@onready var healthBar = $VBoxContainer/HealthBar
@onready var label = $VBoxContainer/Label

func initialize(nameLabel : String, healthPercent : int):
	label.text = nameLabel
	healthBar.initBar(healthPercent)
