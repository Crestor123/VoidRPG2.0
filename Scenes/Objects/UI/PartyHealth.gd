extends ColorRect

@export var healthBar : PackedScene

@onready var container = $HBoxContainer

func initialize(partyList : Array):
	for item in container.get_children():
		item.queue_free()
	
	for item in partyList:
		var newHealthBar = healthBar.instantiate()
		container.add_child(newHealthBar)
		newHealthBar.initialize(item.name, item.stats.getHealthPercent())
		item.updateHealthBar.connect(newHealthBar.healthBar.setBar)
	pass
